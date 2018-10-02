using System;
using System.Diagnostics;
using System.Windows.Forms;

namespace EnergetiComputer
{
    public partial class EnergetiComputer : Form
    {
        long worktime = 0;
        double kwh = 0;
        double pln = 0;
        PerformanceCounter cpuCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
        public EnergetiComputer()
        {
            InitializeComponent();
            try
            {
                string[] conf = System.IO.File.ReadAllLines("config.ini");
                trackBar1.Value = Int32.Parse(conf[0]);
                trackBar2.Value = Int32.Parse(conf[1]);
                trackBar3.Value = Int32.Parse(conf[2]);
                worktime = Int64.Parse(conf[3]);
                kwh = Double.Parse(conf[3]);
                pln = Double.Parse(conf[3]);
            }
            catch
            {
                MessageBox.Show("Nie można było wczytać konfiguracji.", "Błąd", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                System.IO.File.WriteAllLines("config.ini", new string[] { trackBar1.Value.ToString(), trackBar2.Value.ToString(), trackBar3.Value.ToString(), worktime.ToString(), kwh.ToString(), pln.ToString() });
            }
            catch
            {
                MessageBox.Show("Nie można było zapisać konfiguracji.", "Błąd", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void minute_timer_Tick(object sender, EventArgs e)
        {
            worktime++;
        }

        private void kwh_timer_Tick(object sender, EventArgs e)
        {
            dynamic firstValue = cpuCounter.NextValue();
            System.Threading.Thread.Sleep(500);
            dynamic secondValue = cpuCounter.NextValue();
            kwh += (((trackBar3.Value * (secondValue / 100))+trackBar1.Value+trackBar2.Value)*(2.5/60/60))/1000;
            pln = (kwh * 0.5) + ((kwh * 0.5)*(123/100));
        }

        private void gui_update_Tick(object sender, EventArgs e)
        {
            label4.Text = "Czas Pracy: " + worktime + " min";
            label5.Text = "Zużycie w kWh: " + kwh + " kWh";
            label6.Text = "Koszt utrzymania: " + pln + " zł";
        }

        private void trackBar1_Scroll(object sender, EventArgs e)
        {
            label1.Text = "Pobór monitora: (50 - 70 W): " + trackBar1.Value;
        }

        private void trackBar2_Scroll(object sender, EventArgs e)
        {
            label2.Text = "Pobór dodatkowego sprzętu (głośnik, modem, urz.peryferyjne, jedno gniazdo to ok. 0.5 W, zakres 30 W do 100 W): " + trackBar2.Value;
        }

        private void trackBar3_Scroll(object sender, EventArgs e)
        {
            label3.Text = "Zasilacz i jego moc: (100-2000 W): " + trackBar3.Value;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            kwh = 0;
            pln = 0;
            worktime = 0;
        }
    }
}
