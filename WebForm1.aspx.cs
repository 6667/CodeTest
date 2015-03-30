using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using FrameWork.Components;
using FrameWork.Components.sample;
using FrameWork.Data.sample;
namespace FrameWork.web.Manager.Module.AspTest.CodeTest
{
    public class globle
{
        public static int i = 1;
        public static DataTable table = getdata();
        public static DataTable getdata()
        {
        DataTable table =new DataTable();
        table.Columns.Add("num");
        table.Columns.Add("strProductName");
        table.Columns.Add("strTime");
        return table;
    }
}

    public partial class WebForm1 : System.Web.UI.Page
    {

        #region "SqlDataProvider"
        private string ConnString = string.Empty;

        public WebForm1()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
            ConnString = Common.GetConnString;
        }

        public WebForm1(string strConn)
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
            ConnString = strConn;
        }
        private SqlConnection GetSqlConnection()
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConnString);
                conn.Open();
                return conn;
            }
            catch
            {
                throw new Exception("没有提供数据库连接字符串！");
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Menu_Initial();
            Button_Buy.Click += Button_Buy_Click;        
        }
        protected void Menu_Initial()
        {
            if (!IsPostBack)
            {

                List<string> lst = new List<string>();
                using (SqlConnection conn = GetSqlConnection())
                {
                    using (SqlCommand cmd = new SqlCommand("select Product_ID,Product_Name From at_Product", conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                ListItem node = new ListItem(reader["Product_Name"].ToString(), reader["Product_ID"].ToString());
                                menu.Items.Add(node);
                            }
                        }
                        reader.Dispose();
                        cmd.Dispose();
                        cmd.Dispose();
                    }
                    conn.Dispose();
                    conn.Close();
                }
            }
        }
        public void Button_Buy_Click(object sender, EventArgs e)
        {
            DateTime now=DateTime.Now;
            Buy_Info info=new Buy_Info();
            info.intCustomerID = Convert.ToInt32(CustomerID.Text.ToString());
            info.intProductID = Convert.ToInt32(menu.SelectedValue);
            info.strTime = Convert.ToString(now.Date);
            SqlDataProvider_sample.Instance().Buy(info);
            DataRow row = globle.table.NewRow();
            row[0] = globle.i;
            globle.i=globle.i+1;
            row[1] = menu.SelectedItem;
            row[2] = now.ToLongTimeString().ToString();
            globle.table.Rows.Add(row);
            view.DataSource = globle.table;
            view.DataBind();
        }

        protected void menu_MenuItemClick1(object sender, MenuEventArgs e)
        {
        }

    }
}