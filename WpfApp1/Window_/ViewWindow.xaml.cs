using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Windows;
using System.Windows.Controls;
using WpfApp1.DB_;

namespace WpfApp1.Window_
{
    public partial class ViewWindow : Window
    {
        private i_kak_message_ver4Entities _context = new i_kak_message_ver4Entities();
        private User _user;
        private Conversation _selectedConversation;

        public Conversation SelectedConversation
        {
            get { return _selectedConversation; }
            set
            {
                _selectedConversation = value;
                LoadMessages(_selectedConversation.ConversationID);

            }
        }


        private void btAddNote_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddNote addNote = new Window_.AddNote();
            addNote.ShowDialog();
        }
        private void btAddTaske_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddTask addTask = new Window_.AddTask();
            addTask.ShowDialog();
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


            // Загрузка бесед, где текущий пользователь является участником
            var conversations = _context.Conversations
                .Where(c => c.ConversationParticipants.Any(p => p.UserID == user.UserID))
                .ToList();
            livi2.ItemsSource = conversations;
           
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

        private void LoadMessages(int conversationId)
        {
            var messages = _context.Messages
                .Where(m => m.ConversationID == conversationId)
                .Select(m => new
                {
                    Text = m.MessageText,
                    SenderName = m.User.Username,
                    SentDate = m.SentDate
                })
                .ToList();
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

      



        private void btAddConversation_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddConversation addConversation= new Window_.AddConversation(_user);
            addConversation.ShowDialog();
        }
    }
}