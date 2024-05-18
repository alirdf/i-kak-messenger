using Microsoft.VisualStudio.TestTools.UnitTesting;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfApp1.Class_;

namespace WpfApp1.MainWindow.Tests
{
    [TestClass]
    public class PasswordChecker2Tests
    {

        [TestMethod]
        public void IsValid_WithShortPassword_ReturnsFalse()
        {
            // Arrange

            var passwordChecker = new PasswordChecker2();
            string password = "1234";
            string confirmPassword = "1234";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithEmptyPassword_ReturnsFalse()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "";
            string confirmPassword = "";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithDifferentPasswords_ReturnsFalse()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "Password1";
            string confirmPassword = "Password2";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithoutUpper_ReturnsFalse()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "password1";
            string confirmPassword = "password1";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithoutLower_ReturnsFalse()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "PASSWORD1";
            string confirmPassword = "PASSWORD1";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithoutDigit_ReturnsFalse()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "Password";
            string confirmPassword = "Password";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void IsValid_WithValidPassword_ReturnsTrue()
        {
            // Arrange
            var passwordChecker = new PasswordChecker2();
            string password = "Password1";
            string confirmPassword = "Password1";

            // Act
            bool result = passwordChecker.IsValid(password, confirmPassword);

            // Assert
            Assert.IsTrue(result);
        }
    }
}