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
                if (tbRegPass1.Password.Length < 5 || tbRegPass1.Password.Length < 5 ||
                tbRegPass2.Password.Length < 5)
                {
                    MessageBox.Show("Не менее 5 символов");
                }
                bool hasUpper = false, hasLower = false;
                foreach (char c in tbRegPass1.Password)
                {
                    if (char.IsUpper(c))
                    {
                        hasUpper = true;
                    }
                    if (char.IsLower(c))
                    {
                        hasLower = true;
                    }
                }
                foreach (char c in tbRegPass1.Password)
                {
                    if (char.IsUpper(c))
                    {
                        hasUpper = true;
                    }
                    if (char.IsLower(c))
                    {
                        hasLower = true;
                    }
                }
                if (!hasUpper || !hasLower)
                {
                    MessageBox.Show("Вверхний регистр добавь");
                    return;
                }
                bool hasDigit = false, hasLetter = false;
                foreach (char c in tbRegPass1.Password)
                {
                    if (char.IsDigit(c))
                    {
                        hasDigit = true;
                    }
                    if (char.IsLetter(c))
                    {
                        hasLetter = true;
                    }
                }
                if (!hasDigit || !hasLetter)
                {
                    MessageBox.Show("Цифры");
                    return;
                }
                if (tbRegPass1.Password.Trim() == "" && tbRegPass2.Password.Trim() == "")
                {
                    MessageBox.Show("Введи пароль");
                    return;
                }
                if (user != null)
                {
                    MessageBox.Show("Такой пользователь уже ЕСТЬ");
                    return;

                }
                if (tbRegPass1.Password != tbRegPass2.Password)
                {
                    MessageBox.Show("Пароли НЕ совпадают");
                    return;
                }
                try
                {
                    User usern = new User()
                    {
                        Username = tbRegLog.Text,
                        Password = tbRegPass1.Password
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
    }
}
