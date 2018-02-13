using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Chronoguy
{
    public partial class Chronoguy : Form
    {
        DateTime start;

        int stop_millis = 0;
        int stop_secs = 0;
        int stop_mins = 0;
        int stop_hours = 0;

        public Chronoguy()
        {
            InitializeComponent();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            currentTime.Text = DateTime.Now.ToString("HH:mm");
            timeSinceRun.Text = ((DateTime.Now - Process.GetCurrentProcess().StartTime.ToUniversalTime()).Hours - 2).ToString("D2") + ":" + (DateTime.Now - Process.GetCurrentProcess().StartTime.ToUniversalTime()).Minutes.ToString("D2");
            currentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            label5.Text = "Timestamp: " + (Int32)(DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
        }

        private void webBrowser1_Navigating(object sender, WebBrowserNavigatingEventArgs e)
        {
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            webBrowser1.Refresh();
        }

        private void chart1_Click(object sender, EventArgs e)
        {

        }

        private void notifyIcon1_MouseDoubleClick(object sender, MouseEventArgs e)
        {

        }

        private void Chronoguy_Load(object sender, EventArgs e)
        {
            list.Items.Remove("");
        }

        private void chart1_Click_1(object sender, EventArgs e)
        {

        }

        private void CalculateDatediffButton_Click(object sender, EventArgs e)
        {
            TimeSpan s = (dateStart.Value - dateEnd.Value);
            dateValue.Text = "Różnica: " + string.Format("{0} godzin, {1} minut, {2} sekund i {3} dni.", Math.Abs(s.Hours), Math.Abs(s.Minutes), Math.Abs(s.Seconds), Math.Abs(s.Days));
        }

        private void button6_Click(object sender, EventArgs e)
        {
            button6.Enabled = false;
            if(trackBar1.Value == 0)
            {
                button6.Enabled = true;
            }
            else
            {
                timer2.Enabled = true;
                button7.Enabled = true;
                progressBar1.Enabled = false;
                progressBar1.Value = 0;
                progressBar1.Maximum = (trackBar1.Value*60*60)+10;
                start = DateTime.Now;
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            //MessageBox.Show(string.Format("{0:D2}:{1:D2}:{2:D2}.{3:D4}", time.Hours, time.Minutes, time.Seconds, time.Milliseconds));
            button7.Enabled = false;
            button6.Enabled = true;
            timer2.Enabled = false;
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            TimeSpan time = (DateTime.Now - start);
            label3.Text = string.Format("{0:D2}:{1:D2}:{2:D2}.{3:D3}", time.Hours, time.Minutes, time.Seconds, time.Milliseconds);
            if (time.TotalMinutes >= trackBar1.Value)
            {
                timer2.Enabled = false;
                button6.Enabled = true;
                button5.Enabled = false;
            }
            else if (progressBar1.Value + 2 == progressBar1.Maximum)
            {
                progressBar1.Maximum += 1;
            } else progressBar1.Value = progressBar1.Value + 1;
        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {
            label4.Text = "Czas Docelowy: " + trackBar1.Value + " minut";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            timer3.Enabled = true;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            timer3.Enabled = false;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            stop_millis = 0;
            stop_secs = 0;
            stop_mins = 0;
            stop_hours = 0;
            label2.Text = "00:00:00.00";
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            stop_millis += 1;
            if (stop_millis >= 99)
            {
                stop_millis = 0;
                stop_secs++;
                if(stop_secs >= 60)
                {
                    stop_secs = 0;
                    stop_mins++;
                    if(stop_mins >= 60)
                    {
                        stop_mins = 0;
                        stop_hours++; //i dont fucking care about it
                    }
                }
            }

            label2.Text = string.Format("{0:D2}:{1:D2}:{2:D2}.{3:D2}", stop_hours, stop_mins, stop_secs, stop_millis);
        }

        private void button5_Click(object sender, EventArgs e)
        {
            list.Items.Add(label2.Text);
        }
    }
}
