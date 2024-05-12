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
using System.Windows.Shapes;
using WpfApp1.DB_;

namespace WpfApp1.Window_
{
    /// <summary>
    /// Interaction logic for AddTask.xaml
    /// </summary>
    public partial class AddTask : Window
    {
        private i_kak_message_ver4Entities _context = new i_kak_message_ver4Entities();
        private User _user;
        public AddTask(User user)
        {
            InitializeComponent();
            _user = user;
            _context = new i_kak_message_ver4Entities();
        }

        private void btEnter_Click(object sender, RoutedEventArgs e)
        {
            string taskDescription = tbTask.Text.Trim();
            DateTime dueDate = dpTask.SelectedDate ?? DateTime.Today.AddDays(7);

            if (!string.IsNullOrEmpty(taskDescription))
            {
                DB_.Task newTask = new DB_.Task
                {
                    AssignedToID = _user.UserID,
                    AssignedByID = _user.UserID,
                    TaskDescription = taskDescription,
                    CreatedDate = DateTime.Now,
                    DueDate = dueDate,
                    Status = false
                };

                _context.Tasks.Add(newTask);
                _context.SaveChanges();

                DialogResult = true;
                Close();
            }
            else
            {
                MessageBox.Show("Пожалуйста, введите текст задачи.");
            }
        }
    }
}
