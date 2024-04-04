using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using WpfApp1.DB_;
using System.Data.Entity;
using System.Runtime.Remoting.Messaging;

namespace WpfApp1.Window_
{
    /// <summary>
    /// Interaction logic for ViewWindow.xaml
    /// </summary>
    public partial class ViewWindow : Window
    {
        DB_.i_kak_message_ver4Entities _context = new DB_.i_kak_message_ver4Entities();
        User _user;
        public ViewWindow(User user)
        {
            InitializeComponent();
            _user = user;

            // Загрузка задач для текущего пользователя
            data1.ItemsSource = _context.Tasks
                .Where(t => t.AssignedToID == user.UserID || t.AssignedByID == user.UserID)
                .ToList();

            // Загрузка заметок для текущего пользователя
            data2.ItemsSource = _context.Notes
                .Where(n => n.UserID == user.UserID)
                .ToList();

            // Загрузка сообщений в беседах, где текущий пользователь является участником
            var conversationIds = _context.ConversationParticipants
                .Where(p => p.UserID == user.UserID)
                .Select(p => p.ConversationID)
                .ToList();

            livi.ItemsSource = _context.Messages
                .Where(m => conversationIds.Contains(m.ConversationID))
                .ToList();

            // Загрузка бесед, где текущий пользователь является участником
            livi2.ItemsSource = _context.Conversations
                .Where(c => c.ConversationParticipants.Any(p => p.UserID == user.UserID))
                .ToList();

            //data1.ItemsSource = _context.Notes.Where(x => x.UserID == user.UserID).ToList();
            //data2.ItemsSource = _context.Notes.Where(x => x.UserID == user.UserID).ToList();
            //livi.ItemsSource = _context.Notes.Where(x => x.UserID == user.UserID).ToList();
            //livi2.ItemsSource = _context.Notes.Where(x => x.UserID == user.UserID).ToList();

            //using(var _context = new DB_.i_kak_message_ver4Entities())
            //{

            //    //data1.ItemsSource = _context.Notes.Where(x => x.UserID == usern.UserID).ToList();
            //    //livi.ItemsSource = _context.Messages.ToList();
            //    //data1.ItemsSource = _context.Tasks.ToList();
            //    //data2.ItemsSource = _context.Notes.ToList();
            //    //livi2.ItemsSource = _context.Conversations.ToList();
            //}
        }
        private void lvConversations_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (livi2.SelectedItem != null)
            {
                Conversation selectedConversation = (Conversation)livi2.SelectedItem;
                LoadMessages(selectedConversation.ConversationID);
            }
        }
        private void LoadMessages(int conversationId)
        {
            var messages = _context.Messages.Where(m => m.ConversationID == conversationId).ToList();
            livi2.ItemsSource = messages;
        }
        private void SendMessage(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(tbMessage.Text))
            {
                Message newMessage = new Message
                {
                    //SenderID = CurrentUser.UserID,
                    //ConversationID = SelectedConversation.ConversationID,
                    MessageText = tbMessage.Text,
                    SentDate = DateTime.Now
                };

                _context.Messages.Add(newMessage);
                _context.SaveChanges();

                //LoadMessages(SelectedConversation.ConversationID);
                tbMessage.Clear();
            }
        }
    }
}
