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
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfApp1.DB_;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }



        private void btAuto_Click(object sender, RoutedEventArgs e)
        {
            using (var _context = new DB_.i_kak_message_ver4Entities())
            {
                var user = _context.Users.FirstOrDefault(x => x.Username == tbAutoLog.Text && x.Password == tbAutoPass.Password);
                if (user != null)
                {
                    Window_.ViewWindow a = new Window_.ViewWindow(user);
                    a.Show();
                    this.Close();
                }
                else
                {
                    { MessageBox.Show("НЕ верный пароль или логин"); }
                }
            }

        }

        private void btReg_Click(object sender, RoutedEventArgs e)
        {
            using (var _context = new DB_.i_kak_message_ver4Entities())
            {
                var user = _context.Users.FirstOrDefault(x => x.Username == tbRegLog.Text);
                if (string.IsNullOrWhiteSpace(tbRegLog.Text) ||
                    string.IsNullOrWhiteSpace(tbRegPass1.Password) ||
                    string.IsNullOrWhiteSpace(tbRegPass2.Password) ||
                    string.IsNullOrWhiteSpace(tbRegEmail.Text))
                {
                    MessageBox.Show("Все поля должны быть заполнены.");
                    return;
                }

                const int maxUsernameLength = 50;
                const int minPasswordLength = 5;
                const int maxPasswordLength = 100;
                const int maxEmailLength = 100;

                if (tbRegLog.Text.Length > maxUsernameLength)
                {
                    MessageBox.Show($"Имя пользователя не должно превышать {maxUsernameLength} символов.");
                    return;
                }

                if (tbRegPass1.Password.Length < minPasswordLength || tbRegPass1.Password.Length > maxPasswordLength)
                {
                    MessageBox.Show($"Пароль должен быть от {minPasswordLength} до {maxPasswordLength} символов.");
                    return;
                }

                if (tbRegEmail.Text.Length > maxEmailLength)
                {
                    MessageBox.Show($"Электронная почта не должна превышать {maxEmailLength} символов.");
                    return;
                }

                if (!IsValidEmail(tbRegEmail.Text))
                {
                    MessageBox.Show("Неверный формат электронной почты.");
                    return;
                }

                if (user != null)
                {
                    MessageBox.Show("Пользователь с таким именем уже существует.");
                    return;
                }

                if (tbRegPass1.Password != tbRegPass2.Password)
                {
                    MessageBox.Show("Пароли не совпадают.");
                    return;
                }

                try
                {
                    User usern = new User()
                    {
                        Username = tbRegLog.Text,
                        Password = tbRegPass1.Password,
                        Email = tbRegEmail.Text,
                        RegistrationDate = DateTime.Now
                    };
                    _context.Users.Add(usern);
                    _context.SaveChanges();
                    MessageBox.Show("Регистрация успешна");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

    }
}
