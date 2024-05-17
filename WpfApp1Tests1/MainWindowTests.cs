using Microsoft.VisualStudio.TestTools.UnitTesting;
using WpfApp1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfApp1.DB_;

namespace WpfApp1.Tests
{
    [TestClass]
    public class MainWindowTests
    {
        private MainWindow mainWindow;
        private DB_.i_kak_message_ver4Entities context;

        [TestInitialize]
        public void Setup()
        {
            mainWindow = new MainWindow();
            context = new DB_.i_kak_message_ver4Entities();
        }

        [TestCleanup]
        public void Cleanup()
        {
            mainWindow.Dispose();
            context.Dispose();
        }

        [TestMethod]
        public void btReg_Click_WithShortPassword_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "testuser";
            mainWindow.tbRegPass1.Password = "1234";
            mainWindow.tbRegPass2.Password = "1234";

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Не менее 5 символов", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithoutUpperAndLowerCase_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "testuser";
            mainWindow.tbRegPass1.Password = "12345";
            mainWindow.tbRegPass2.Password = "12345";

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Вверхний регистр добавь", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithoutDigits_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "testuser";
            mainWindow.tbRegPass1.Password = "ABCDEF";
            mainWindow.tbRegPass2.Password = "ABCDEF";

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Цифры", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithEmptyPassword_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "testuser";
            mainWindow.tbRegPass1.Password = "";
            mainWindow.tbRegPass2.Password = "";

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Введи пароль", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithExistingUsername_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "existinguser";
            mainWindow.tbRegPass1.Password = "password123";
            mainWindow.tbRegPass2.Password = "password123";
            context.Users.Add(new User { Username = "existinguser" });
            context.SaveChanges();

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Такой пользователь уже ЕСТЬ", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithNonMatchingPasswords_DisplaysErrorMessage()
        {
            // Arrange
            mainWindow.tbRegLog.Text = "testuser";
            mainWindow.tbRegPass1.Password = "password123";
            mainWindow.tbRegPass2.Password = "password456";

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            Assert.AreEqual("Пароли НЕ совпадают", mainWindow.MessageBoxText);
        }

        [TestMethod]
        public void btReg_Click_WithValidData_AddsUserToDatabase()
        {
            // Arrange
            string username = "validuser";
            string password = "Password123";
            mainWindow.tbRegLog.Text = username;
            mainWindow.tbRegPass1.Password = password;
            mainWindow.tbRegPass2.Password = password;

            // Act
            mainWindow.btReg_Click(null, null);

            // Assert
            User user = context.Users.FirstOrDefault(u => u.Username == username);
            Assert.IsNotNull(user);
            Assert.AreEqual(username, user.Username);
            Assert.AreEqual(password, user.Password);
        }
    }
}