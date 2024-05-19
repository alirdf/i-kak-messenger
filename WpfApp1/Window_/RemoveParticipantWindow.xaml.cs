using System.Collections.Generic;
using System.Windows;
using WpfApp1.DB_;

namespace WpfApp1.Window_
{
    public partial class RemoveParticipantWindow : Window
    {
        public int SelectedUserId { get; private set; }

        public RemoveParticipantWindow(int conversationId, List<User> conversationParticipants)
        {
            InitializeComponent();
            lbUsers.ItemsSource = conversationParticipants;
        }

        private void RemoveButton_Click(object sender, RoutedEventArgs e)
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