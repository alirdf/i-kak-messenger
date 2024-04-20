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
        private Conversation _selectedConversation;
        public Conversation SelectedConversation
        {
            get { return _selectedConversation; }
            set
            {
                _selectedConversation = value;
                // Дополнительная логика при изменении выбранной беседы
                LoadMessages(_selectedConversation.ConversationID);
            }
        }

        public User CurrentUser
        {
            get { return _user; }
            set { _user = value; }
        }
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
            livi.ItemsSource = messages;
        }
        private void SendMessage(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(tbMessage.Text))
            {
                // Создать новое сообщение
                Message newMessage = new Message
                {
                    SenderID = CurrentUser.UserID,
                    ConversationID = SelectedConversation.ConversationID,
                    MessageText = tbMessage.Text,
                    SentDate = DateTime.Now
                };

                // Добавить сообщение в базу данных
                _context.Messages.Add(newMessage);
                _context.SaveChanges();

                // Создать уведомления для остальных участников беседы
                var participants = _context.ConversationParticipants
                    .Where(p => p.ConversationID == SelectedConversation.ConversationID
                                && p.UserID != CurrentUser.UserID)
                    .Select(p => p.UserID)
                    .ToList();

                foreach (int userId in participants)
                {
                    Notification notification = new Notification
                    {
                        UserID = userId,
                        NotificationType = "M",
                        NotificationText = $"Новое сообщение в беседе '{SelectedConversation.ConversationName}'",
                        CreatedDate = DateTime.Now,
                        IsRead = false
                    };

                    _context.Notifications.Add(notification);
                }

                _context.SaveChanges();

                // Обновить список сообщений
                LoadMessages(SelectedConversation.ConversationID);

                // Очистить текстовое поле для ввода сообщения
                tbMessage.Clear();
            }
        }
        

        private void btEnter_Click(object sender, RoutedEventArgs e)// добавить сообщение
        {
            if (!string.IsNullOrWhiteSpace(tbMessage.Text))
            {
                Message newMessage = new Message
                {

                    SenderID = CurrentUser.UserID,
                    ConversationID = SelectedConversation.ConversationID,
                    MessageText = tbMessage.Text,
                    SentDate = DateTime.Now
                };

                // Создать уведомления для остальных участников беседы
                var participants = _context.ConversationParticipants
                    .Where(p => p.ConversationID == SelectedConversation.ConversationID
                                && p.UserID != CurrentUser.UserID)
                    .Select(p => p.UserID)
                    .ToList();

                    foreach (int userId in participants)
                    {
                        Notification notification = new Notification
                        {
                            UserID = userId,
                            NotificationType = "M",
                            NotificationText = $"Новое сообщение в беседе '{SelectedConversation.ConversationName}'",
                            CreatedDate = DateTime.Now,
                            IsRead = false
                        };

                        _context.Notifications.Add(notification);
                    }
                _context.Messages.Add(newMessage);
                _context.SaveChanges();

                LoadMessages(SelectedConversation.ConversationID);
                tbMessage.Clear();
            }
        }

        private void btAddNote_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddTask addTask = new Window_.AddTask();
            addTask.ShowDialog();
        }

        private void btAddTaske_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddTask addTask = new Window_.AddTask();
            addTask.ShowDialog();
        }

        private void livi2_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (livi2.SelectedItem != null)
            {
                _selectedConversation = livi2.SelectedItem as Conversation;
                if (_selectedConversation != null)
                {
                    LoadMessages(_selectedConversation.ConversationID);
                }
            }

        }
    }
}
