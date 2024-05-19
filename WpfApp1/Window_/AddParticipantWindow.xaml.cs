using System.Collections.Generic;
using System.Windows;
using WpfApp1.DB_;

namespace WpfApp1.Window_
{
    public partial class AddParticipantWindow : Window
    {
        public int SelectedUserId { get; private set; }

        public AddParticipantWindow(int conversationId, List<User> users)
        {
            InitializeComponent();
            lbUsers.ItemsSource = users;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (lbUsers.SelectedItem is User selectedUser)
            {
                SelectedUserId = selectedUser.UserID;
                DialogResult = true;
                Close();
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}