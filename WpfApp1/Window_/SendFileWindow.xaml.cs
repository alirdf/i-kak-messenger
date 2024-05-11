using System;
using System.Collections.Generic;
using System.IO;
using System.Management;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Win32;
using WpfApp1.DB_;


namespace WpfApp1.Window_
{
    public partial class SendFileWindow : Window
    {
        private User _currentUser;
        private List<User> _users;
        private User _selectedReceiver;
        private string _selectedFilePath;

        public SendFileWindow(User currentUser, List<User> users)
        {
            InitializeComponent();
            _currentUser = currentUser;
            _users = users;
            lvUsers.ItemsSource = _users;
        }

        public User SelectedReceiver
        {
            get { return _selectedReceiver; }
        }

        public string SelectedFilePath
        {
            get { return _selectedFilePath; }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }

        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            if (lvUsers.SelectedItem is User selectedUser)
            {
                _selectedReceiver = selectedUser;
                _selectedFilePath = ChooseFile();
                if (!string.IsNullOrEmpty(_selectedFilePath))
                {
                    SendFile(_selectedReceiver.Username, _selectedFilePath);
                    DialogResult = true;
                    Close();
                }
            }
        }

        private string ChooseFile()
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            if (openFileDialog.ShowDialog() == true)
            {
                return openFileDialog.FileName;
            }
            return string.Empty;
        }

        private void SendFile(string username, string filePath)
        {
            try
            {
                // Получение информации о компьютере по имени пользователя
                ManagementScope scope = new ManagementScope($"\\\\{GetComputerNameByUsername(username)}\\root\\cimv2");
                scope.Connect();

                // Создание объекта для копирования файла
                ManagementClass fileTransfer = new ManagementClass(scope, new ManagementPath("Win32_DataFile"), null);
                ManagementBaseObject inParams = fileTransfer.GetMethodParameters("CopyFile");

                // Установка параметров копирования
                inParams["SourceFile"] = filePath;
                inParams["DestinationFile"] = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), Path.GetFileName(filePath));
                inParams["Overwrite"] = true;

                // Выполнение копирования файла
                ManagementBaseObject outParams = fileTransfer.InvokeMethod("CopyFile", inParams, null);

                // Проверка результата копирования
                uint returnValue = (uint)outParams.Properties["ReturnValue"].Value;
                if (returnValue == 0)
                {
                    MessageBox.Show($"Файл '{Path.GetFileName(filePath)}' успешно отправлен на ПК {username}.");
                }
                else
                {
                    MessageBox.Show($"Ошибка при отправке файла '{Path.GetFileName(filePath)}' на ПК {username}.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при отправке файла: {ex.Message}");
            }
        }

        private string GetComputerNameByUsername(string username)
        {
            try
            {
                // Получение информации о пользователе
                ManagementObjectSearcher searcher = new ManagementObjectSearcher($"SELECT * FROM Win32_UserAccount WHERE Name = '{username}'");
                ManagementObjectCollection collection = searcher.Get();

                // Получение имени компьютера
                foreach (ManagementObject obj in collection)
                {
                    return (string)obj["Domain"];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при получении имени компьютера: {ex.Message}");
            }

            return string.Empty;
        }
    }
}