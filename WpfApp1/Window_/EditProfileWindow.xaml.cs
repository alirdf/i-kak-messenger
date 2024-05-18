using System.Windows;
using WpfApp1.DB_;

namespace WpfApp1.Window_
{
    public partial class EditProfileWindow : Window
    {
        private User _user;

        public EditProfileWindow(User user)
        {
            InitializeComponent();
            _user = user;
            tbUsername.Text = _user.Username;
            tbEmail.Text = _user.Email;
        }

        private void SaveProfileButton_Click(object sender, RoutedEventArgs e)
        {
            _user.Username = tbUsername.Text;
            _user.Email = tbEmail.Text;

            using (var context = new i_kak_message_ver4Entities())
            {
                context.Entry(_user).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }

            MessageBox.Show("Профиль обновлен успешно.");
            this.Close();
        }

        private void SavePasswordButton_Click(object sender, RoutedEventArgs e)
        {
            string oldPassword = tbOldPassword.Password;
            string newPassword = tbNewPassword.Password;

            if (_user.Password != oldPassword)
            {
                MessageBox.Show("Старый пароль неверный.");
                return;
            }

            if (newPassword.Length < 5)
            {
                MessageBox.Show("Новый пароль должен быть не менее 5 символов.");
                return;
            }

            _user.Password = newPassword;

            using (var context = new i_kak_message_ver4Entities())
            {
                context.Entry(_user).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();
            }

            MessageBox.Show("Пароль изменен успешно.");
            this.Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}