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
using System.Data.Entity;
using System.Net.Sockets;
using System.Text;
using System.Threading;

using System.Net;
using System.Management;
using System.Runtime.Remoting.Contexts;


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
        }  // Выбранная беседа
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



        }// Конструктор программы -----------------------------------------------------------------------------------------------------------
        private void ViewWindow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.F5)
            {
                RefreshData();
            }
        }// Обработка нажатия клавиши F5 -----------------------------------------------------------------------------------------------------
        public void RefreshData()
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
        } // Обновление данных ---------------------------------------------------------------------------------------------------------------
        private void ViewWindow_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (IsVisible)
            {
                RefreshData();
            }
        } // Обработка изменения видимости окна ---------------------------------------------------------------------------------------------
        private void btAddNote_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddNote addNote = new Window_.AddNote(user: _user);
            addNote.ShowDialog();
        } // Добавление заметки ---------------------------------------------------------------------------------------------------------------
        private void btAddTaske_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddTask addTask = new Window_.AddTask(user: _user);
            addTask.ShowDialog();
        } // Добавление задачи ---------------------------------------------------------------------------------------------------------------
        public User CurrentUser
        {
            get { return _user; }
            set { _user = value; }
        }// Текущий пользователь ---------------------------------------------------------------------------------------------------------------
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
        }// Выбор беседы ---------------------------------------------------------------------------------------------------------------
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
        }// Загрузка сообщений ---------------------------------------------------------------------------------------------------------------
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
        }// Отправка сообщения ---------------------------------------------------------------------------------------------------------------
        private void btAddConversation_Click(object sender, RoutedEventArgs e)
        {
            Window_.AddConversation addConversation = new Window_.AddConversation(_user);
            addConversation.ShowDialog();
        }// Добавление беседы ---------------------------------------------------------------------------------------------------------------
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
        }// Обновление данных ---------------------------------------------------------------------------------------------------------------
        private void btSendfile_Click(object sender, RoutedEventArgs e)
        {
            SendFileWindow sendFileWindow = new SendFileWindow(_user, _context.Users.Where(u => u.UserID != _user.UserID).ToList());
            if (sendFileWindow.ShowDialog() == true)
            {
                User selectedReceiver = sendFileWindow.SelectedReceiver;
                string selectedFilePath = sendFileWindow.SelectedFilePath;

                if (!string.IsNullOrEmpty(selectedFilePath))
                {
                    // Отправка файла
                    SendFile(selectedReceiver.Username, selectedFilePath);
                    MessageBox.Show($"Файл '{Path.GetFileName(selectedFilePath)}' успешно отправлен пользователю {selectedReceiver.Username}.");
                }
            }
        }// Отправка файла ---------------------------------------------------------------------------------------------------------------
        private void SendFile(string username, string filePath)
        {
            try
            {
                // Получение информации о компьютере по имени пользователя
                ManagementScope scope = new ManagementScope($"\\\\{GetComputerNameByUsername(username)}\\root\\cimv2");
                scope.Connect();

                // Создание объекта для копирования файла
                ManagementClass fileTransfer = new ManagementClass(scope, new ManagementPath("Win32_DataFile"), null);
                ManagementBaseObject inParams = fileTransfer.GetMethodParameters("CopyFile");

                // Установка параметров копирования
                inParams["SourceFile"] = filePath;
                inParams["DestinationFile"] = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), Path.GetFileName(filePath));
                inParams["Overwrite"] = true;

                // Выполнение копирования файла
                ManagementBaseObject outParams = fileTransfer.InvokeMethod("CopyFile", inParams, null);

                // Проверка результата копирования
                uint returnValue = (uint)outParams.Properties["ReturnValue"].Value;
                if (returnValue == 0)
                {
                    MessageBox.Show($"Файл '{Path.GetFileName(filePath)}' успешно отправлен на ПК {username}.");
                }
                else
                {
                    MessageBox.Show($"Ошибка при отправке файла '{Path.GetFileName(filePath)}' на ПК {username}.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при отправке файла: {ex.Message}");
            }
        }// Отправка файла ---------------------------------------------------------------------------------------------------------------
        private string GetComputerNameByUsername(string username)
        {
            try
            {
                // Получение информации о пользователе
                ManagementObjectSearcher searcher = new ManagementObjectSearcher($"SELECT * FROM Win32_UserAccount WHERE Name = '{username}'");
                ManagementObjectCollection collection = searcher.Get();

                // Получение имени компьютера
                foreach (ManagementObject obj in collection)
                {
                    return (string)obj["Domain"];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при получении имени компьютера: {ex.Message}");
            }

            return string.Empty;
        }// Отправка файла ---------------------------------------------------------------------------------------------------------------
        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = tbSearch.Text.ToLower();

            // Поиск по сообщениям
            var filteredMessages = _context.Messages
                .Where(m => m.MessageText.ToLower().Contains(searchText) && (m.SenderID == _user.UserID || m.Conversation.ConversationParticipants.Any(p => p.UserID == _user.UserID)))
                .Select(m => new
                {
                    Text = m.MessageText,
                    SenderName = m.User.Username,
                    SentDate = m.SentDate
                })
                .ToList();
            livi.ItemsSource = filteredMessages;

            // Поиск по названиям бесед
            var filteredConversations = _context.Conversations
                .Where(c => c.ConversationName.ToLower().Contains(searchText) && c.ConversationParticipants.Any(p => p.UserID == _user.UserID))
                .ToList();
            livi2.ItemsSource = filteredConversations;




            //string searchText = tbSearch.Text.ToLower();
            //var st = _context.Messages.ToList();
            //var filteredItems = st
            //.Where(x => x.MessageText.ToLower().Contains(searchText) ||
            //       LevenshteinDistance(x.MessageText.ToLower(), searchText) <= Math.Max(3, searchText.Length - 3))
            //.ToList();

            //livi.ItemsSource = filteredItems;

        }// Поиск сообщений ---------------------------------------------------------------------------------------------------------------
    

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
        }// Поиск сообщений ---------------------------------------------------------------------------------------------------------------
        private void livi2_MouseRightButtonUp(object sender, MouseButtonEventArgs e)
        {
            ListView listView = sender as ListView;
            if (listView != null)
            {
                Conversation conversation = listView.SelectedItem as Conversation;
                if (conversation != null)
                {
                    ContextMenu contextMenu = listView.ContextMenu;
                    if (contextMenu != null)
                    {
                        contextMenu.DataContext = conversation;
                        contextMenu.IsOpen = true;
                    }
                }
            }
        }// Контекстное меню беседы ---------------------------------------------------------------------------------------------------------------
        private void LeaveConversationMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MenuItem menuItem = sender as MenuItem;
            if (menuItem != null && menuItem.DataContext is Conversation)
            {
                Conversation conversation = menuItem.DataContext as Conversation;
                if (MessageBox.Show($"Вы уверены, что хотите выйти из беседы '{conversation.ConversationName}'?", "Выход из беседы", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    LeaveConversation(conversation.ConversationID);
                    RefreshData();
                }
            }
        }// Меню выхода из беседы ---------------------------------------------------------------------------------------------------------------
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
        }// Удаление пользователя из беседы -------------------------------------------------------------------------------------------------------
        private void SaveTasksButton_Click(object sender, RoutedEventArgs e) // Сохранение задач ---------------------------------------------------------------------
        {

            var selectedTasks = data1.SelectedItems.Cast<Task>().ToList();
            if (MessageBox.Show($"Вы точно хотите сохранить изменения в {selectedTasks.Count} задачах?", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    foreach (var task in selectedTasks)
                    {
                        _context.Entry(task).State = EntityState.Modified;
                    }
                    _context.SaveChanges();
                    MessageBox.Show("Изменения в заметках сохранены.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при сохранении задач: {ex.Message}");
                }
            }// Сохранение задач ------------------------------------------------------------------------------- 

        }
        private void SaveNotesButton_Click(object sender, RoutedEventArgs e) {
            var selectedNotes = data2.SelectedItems.Cast<Note>().ToList();
            if (MessageBox.Show($"Вы точно хотите сохранить изменения в {selectedNotes.Count} заметках?", "Внимание", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    foreach (var note in selectedNotes)
                    {
                        _context.Entry(note).State = EntityState.Modified;
                    }
                    _context.SaveChanges();
                    MessageBox.Show("Изменения в заметках сохранены.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при сохранении заметок: {ex.Message}");
                }
            }
        }// Сохранения заметок ---------------------------------------------------------------------------------------
        private void btDellTask_Click(object sender, RoutedEventArgs e)
        {
            using (var context = new i_kak_message_ver4Entities())
            {
                try
                {
                    using (var _context = new DB_.i_kak_message_ver4Entities())
                    {
                        var r1 = data1.SelectedItems.Cast<Task>().ToList();
                        if (MessageBox.Show($" Точно удалить {r1.Count}", "Внимание",
                            MessageBoxButton.YesNo,
                            MessageBoxImage.Question) ==
                            MessageBoxResult.Yes)
                        {
                            var r2 = r1.Select(m => m.TaskID).ToList();
                            var r3 = _context.Tasks.Where(m => r2.Contains(m.TaskID)).ToList();
                            _context.Tasks.RemoveRange(r3);
                            _context.SaveChanges();
                            MessageBox.Show("Удалено");
                            data1.ItemsSource = context.Tasks.Where(t => t.AssignedToID == _user.UserID || t.AssignedByID == _user.UserID).ToList();
                        }
                    }
                }
                catch { MessageBox.Show("Ошибока"); }
            }
        }// Удаление задач----------------------------------------------------------------------------------------------------------------
        private void btDellNote_Click(object sender, RoutedEventArgs e)
        {
            using (var context = new i_kak_message_ver4Entities())
            {
                try
                {
                    using (var _context = new DB_.i_kak_message_ver4Entities())
                    {
                        var r1 = data2.SelectedItems.Cast<Note>().ToList();
                        if (MessageBox.Show($" Точно удалить {r1.Count}", "Внимание",
                            MessageBoxButton.YesNo,
                            MessageBoxImage.Question) ==
                            MessageBoxResult.Yes)
                        {
                            var r2 = r1.Select(m => m.NoteID).ToList();
                            var r3 = _context.Notes.Where(m => r2.Contains(m.NoteID)).ToList();
                            _context.Notes.RemoveRange(r3);
                            _context.SaveChanges();
                            MessageBox.Show("Удалено");
                            data2.ItemsSource = _context.Notes.Where(n => n.UserID == _user.UserID).ToList();
                        }
                    }
                }
                catch { MessageBox.Show("Ошибока"); }
            }

        }// Удаление заметок ----------------------------------------------------------------------------------------------------------------
    }
}



