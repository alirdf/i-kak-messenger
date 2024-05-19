using System.Windows;

namespace WpfApp1.Window_
{
    public partial class UpdateConversationNameWindow : Window
    {
        public string NewConversationName { get; private set; }

        public UpdateConversationNameWindow(int conversationId, string currentName)
        {
            InitializeComponent();
            tbConversationName.Text = currentName;
        }

        private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            NewConversationName = tbConversationName.Text;
            DialogResult = true;
            Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}