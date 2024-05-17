using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WpfApp1.Class_
{
    public class PasswordChecker2
    {
        public bool IsValid(string password, string confirmPassword)
        {
            if (password.Length < 5)
            {
                MessageBox.Show("Не менее 5 символов");
                return false;
            }

            if (password.Trim() == "" && confirmPassword.Trim() == "")
            {
                MessageBox.Show("Введи пароль");
                return false;
            }

            if (password != confirmPassword)
            {
                MessageBox.Show("Пароли НЕ совпадают");
                return false;
            }

            bool hasUpper = false, hasLower = false, hasDigit = false;
            foreach (char c in password)
            {
                if (char.IsUpper(c))
                {
                    hasUpper = true;
                }
                if (char.IsLower(c))
                {
                    hasLower = true;
                }
                if (char.IsDigit(c))
                {
                    hasDigit = true;
                }
            }

            if (!hasUpper)
            {
                MessageBox.Show("Вверхний регистр добавь");
                return false;
            }

            if (!hasLower)
            {
                MessageBox.Show("Нижний регистр добавь");
                return false;
            }

            if (!hasDigit)
            {
                MessageBox.Show("Цифры");
                return false;
            }

            return true;
        }
    }
}
