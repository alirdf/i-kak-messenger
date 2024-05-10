using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using WpfApp1.DB_;
using System.IO;

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
        public ViewWindow(User user)
        {
            InitializeComponent();
            _user = user;
            

            IsVisibleChanged += ViewWindow_IsVisibleChanged;
            KeyDown += ViewWindow_KeyDown;
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
        private void ViewWindow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.F5)
            {
                RefreshData();
            }
        }

        private void RefreshData()
        {
            _context.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());

            data1.ItemsSource = _context.Tasks
                .Where(t => t.AssignedToID == _user.UserID || t.AssignedByID == _user.UserID)
                .ToList();

            data2.ItemsSource = _context.Notes
                .Where(n => n.UserID == _user.UserID)
                .ToList();

            var conversations = _context.Conversations
                .Where(c => c.ConversationParticipants.Any(p => p.UserID == _user.UserID))
                .ToList();

            livi2.ItemsSource = conversations;
        }

        private void ViewWindow_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (IsVisible)
            {
                RefreshData();
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
            Window_.AddConversation addConversation = new Window_.AddConversation(_user);
            addConversation.ShowDialog();
        }

        private void Window_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e) //что то не работает
        
        {
            if (Visibility == Visibility.Visible)

                _context.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());

            data1.ItemsSource = _context.Tasks
                .Where(t => t.AssignedToID == _user.UserID || t.AssignedByID == _user.UserID)
                .ToList();

            data2.ItemsSource = _context.Notes
                .Where(n => n.UserID == _user.UserID)
                .ToList();

            var conversations = _context.Conversations
                .Where(c => c.ConversationParticipants.Any(p => p.UserID == _user.UserID))
                .ToList();

            livi2.ItemsSource = conversations;
        }
        private void btSendfile_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            if (openFileDialog.ShowDialog() == true)
            {
                byte[] fileBytes = File.ReadAllBytes(openFileDialog.FileName);
                string fileName = Path.GetFileName(openFileDialog.FileName);

                Message newMessage = new Message
                {
                    SenderID = CurrentUser.UserID,
                    ConversationID = SelectedConversation.ConversationID,
                    MessageText = $"[Файл: {fileName}]",
                    FileContent = fileBytes,
                    SentDate = DateTime.Now
                };

                _context.Messages.Add(newMessage);
                _context.SaveChanges();

                LoadMessages(SelectedConversation.ConversationID);
            }
        }
        private void StackPanel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            StackPanel stackPanel = sender as StackPanel;
            if (stackPanel != null)
            {
                Message message = stackPanel.DataContext as Message;
                if (message != null)
                {
                    using (var context = new DB_.i_kak_message_ver4Entities())
                    {
                        var dbMessage = context.Messages.FirstOrDefault(m => m.MessageID == message.MessageID);
                        if (dbMessage != null && dbMessage.FileContent != null)
                        {
                            SaveFileDialog saveFileDialog = new SaveFileDialog();
                            saveFileDialog.FileName = dbMessage.MessageText.Replace("[Файл: ", "").Replace("]", "");
                            if (saveFileDialog.ShowDialog() == true)
                            {
                                File.WriteAllBytes(saveFileDialog.FileName, dbMessage.FileContent);
                            }
                        }
                    }
                }
            }
        }
        private void LeaveConversation(int conversationId)
        {
            using (var context = new DB_.i_kak_message_ver4Entities())
            {
                var participant = context.ConversationParticipants.FirstOrDefault(p => p.ConversationID == conversationId && p.UserID == _user.UserID);
                if (participant != null)
                {
                    context.ConversationParticipants.Remove(participant);
                    context.SaveChanges();
                }
            }
        }



        //Поиск с расстоянием Левенштейна

        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = tbSearch.Text.ToLower();
            var st = _context.Messages.ToList();
            var filteredItems = st
            .Where(x => x.MessageText.ToLower().Contains(searchText) ||
                   LevenshteinDistance(x.MessageText.ToLower(), searchText) <= Math.Max(3, searchText.Length - 3))
            .ToList();

            livi.ItemsSource = filteredItems;

        }
       
      
        public static int LevenshteinDistance(string s1, string s2)
        {
            int[,] d = new int[s1.Length + 1, s2.Length + 1];

            for (int i = 0; i <= s1.Length; i++)
            {
                d[i, 0] = i;
            }

            for (int j = 0; j <= s2.Length; j++)
            {
                d[0, j] = j;
            }

            for (int i = 1; i <= s1.Length; i++)
            {
                for (int j = 1; j <= s2.Length; j++)
                {
                    int cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
                    d[i, j] = Math.Min(Math.Min(d[i - 1, j] + 1, d[i, j - 1] + 1), d[i - 1, j - 1] + cost);
                }
            }

            return d[s1.Length, s2.Length];
        }

       

        private void btLeaveConversation_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;
            if (button != null && button.DataContext is Conversation)
            {
                Conversation conversation = button.DataContext as Conversation;
                LeaveConversation(conversation.ConversationID);
                RefreshData();
            }
        }
    }
}