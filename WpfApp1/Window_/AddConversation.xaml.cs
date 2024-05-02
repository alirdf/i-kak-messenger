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


namespace WpfApp1.Window_
{
    /// <summary>
    /// Interaction logic for AddConversation.xaml
    /// </summary>
    public partial class AddConversation : Window
    {
        private i_kak_message_ver4Entities _context = new i_kak_message_ver4Entities();
        private User _currentUser;

        public AddConversation(User currentUser)
        {
            InitializeComponent();
            _currentUser = currentUser;

            // Загрузить список всех пользователей, кроме текущего
            Users = _context.Users
        .Where(u => u.UserID != currentUser.UserID)
        .ToList();
            DataContext = this;

            //DataContext = this;
            //var users = _context.Users
            //    .Where(u => u.UserID != currentUser.UserID)
            //    .ToList();
            //lbParticipants.ItemsSource = users;
        }
        public List<User> Users { get; set; }
        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void CreateButton_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtConversationName.Text))
            {
                List<User> selectedParticipants = lbParticipants.SelectedItems.Cast<User>().ToList();
                selectedParticipants.Add(_currentUser); // Добавить текущего пользователя в беседу

                CreateConversation(txtConversationName.Text, selectedParticipants);
                Close();
            }
            else
            {
                MessageBox.Show("Пожалуйста, введите название беседы.");
            }
        }
        private void CreateConversation(string conversationName, List<User> participants)
        {
            // Создать новую беседу
            Conversation newConversation = new Conversation
            {
                ConversationName = conversationName,
                ConversationType = "G" // Групповая беседа
            };
            _context.Conversations.Add(newConversation);
            _context.SaveChanges();

            // Добавить участников в беседу
            foreach (User participant in participants)
            {
                ConversationParticipant newParticipant = new ConversationParticipant
                {
                    ConversationID = newConversation.ConversationID,
                    UserID = participant.UserID,
                    JoinedDate = DateTime.Now
                };
                _context.ConversationParticipants.Add(newParticipant);
            }
            _context.SaveChanges();
        }


    }
}
