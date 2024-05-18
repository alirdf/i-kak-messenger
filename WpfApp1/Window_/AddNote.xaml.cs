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
    /// Interaction logic for AddNote.xaml
    /// </summary>
    public partial class AddNote : Window
    {
        private i_kak_message_ver4Entities _context = new i_kak_message_ver4Entities();
        private User _user;

        public AddNote(User user)
        {
            InitializeComponent();
            _user = user;
            _context = new i_kak_message_ver4Entities();
        }

       
        private void btEnter_Click_1(object sender, RoutedEventArgs e)
        {
            string noteText = tbTask.Text.Trim();

            if (!string.IsNullOrEmpty(noteText))
            {
                Note newNote = new Note
                {
                    UserID = _user.UserID,
                    NoteText = noteText,
                    CreatedDate = DateTime.Now
                };

                _context.Notes.Add(newNote);
                _context.SaveChanges();

                DialogResult = true;
                Close();
            }
            else
            {
                MessageBox.Show("Пожалуйста, введите текст заметки.");
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
