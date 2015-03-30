using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;

using FrameWork.Components;
using FrameWork.Components.sample;
using FrameWork.Data.sample;

namespace FrameWork.web.Manager.Module.AspTest.CodeTest
{
    public partial class CustomerInfo : System.Web.UI.Page
    {
        //Page_Load这个函数在每次页面进行加载时，负责对页面的初始化以及页面上控件的初始化
        protected void Page_Load(object sender, EventArgs e)
        {
            //下面的语句对每个button控件进行函数的绑定
			
            /*我对Button_Search_Click这个函数的使用进行详细说明
             若想查看函数实现，选中函数名然后按F12或者鼠标选中函数名然后右键点击“转到定义”，都跳转到函数
             可以看到此语句把控件Button_Search和函数Button_Search_Click绑定在了一起*/
            Button_Search.Click += Button_Search_Click;
            Button_Save.Click += Button_Save_Click;
            Button_SaveNew.Click += Button_SaveNew_Click;
            Button_Delete.Click += Button_Delete_Click;

            //这个是保证函数第一次加载的时候，一些必要控件的初始化，比如翻页的控件回到第一页
            if (!Page.IsPostBack)
            {
                initial();
            }
        }

        private void initial()
        {
            AspNetPager1.CurrentPageIndex = 1;
            AspNetPager1.PageSize = 10;
            TabOptionWebControls1.SelectIndex = 0;
            Button_Delete.Visible = true;
            Button_Save.Visible = true;
        }

        //请灵活运用region标记，这样方便不同的开发人员以及自己今后对代码进行再次开发和维护
        #region 查询顾客
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        //当你在页面上点击表格中的“查询”按钮后，页面就会调用这个函数
        void Button_Search_Click(object sender, EventArgs e)
        {
            //这个函数实现一个功能，根据传入的查询条件，在表格中绑定满足条件的数据
            BindData();
        }

        //此函数根据你在页面相应位置填写的查询条件，从数据库中读取满足条件的信息
        private void BindData()
        {
            int RecordCount = 0;
			
            //生成一个符合数据库中目标表格式的类对象列表，这个对象列表lst存储了相关表的所有的信息
            List<Customer_Info> lst = new List<Customer_Info>();
			
            //catchKeyWord这个对象只是用来存放查询条件的信息，你完全可以用两个string变量存储查询条件，但是
            //采用这种方法比较方便也便于以后的开发
            Customer_Info catchKeyWord = new Customer_Info();
            catchKeyWord.strCustomerName = TextBox_CustomerName.Text.ToString();
            catchKeyWord.strCustomerPhone = TextBox_CustomerPhone.Text.ToString();
			
            //Keywords_Table_Search这个函数就是在进行数据的筛选
            lst = BusinessFacade_sample.Keywords_Table_Search(AspNetPager1.PageSize, AspNetPager1.CurrentPageIndex, catchKeyWord, out RecordCount);

            GridView1.DataSource = lst;
            GridView1.DataBind();
            this.AspNetPager1.RecordCount = RecordCount;
            TabOptionWebControls1.SelectIndex = 0;
        }
        #endregion

        #region 顾客详情查看、修改
		//页面缓存，用于存放当前所选顾客的ID，相当于全局变量
        public string _intCustomerID
        {
            get
            {
                if (ViewState["_intCustomerID"] == null)
                    ViewState["_intCustomerID"] = "";

                return (string)ViewState["_intCustomerID"];
            }
            set { ViewState["_intCustomerID"] = value; }
        }

        protected void Button_Operation_Click(object sender, EventArgs e)
        {
            Button button = sender as Button;
            BindDetail(button.CommandArgument);
        }
        private void BindDetail(string view_intCustomerID)
        {
            _intCustomerID = view_intCustomerID;
            int intCustomerID = 0;
            if (int.TryParse(view_intCustomerID, out intCustomerID))
            {
                Customer_Info targetCusInfo = new Customer_Info();
                targetCusInfo = BusinessFacade_sample.Customer_Search(intCustomerID);
                tb_CustomerName.Text = targetCusInfo.strCustomerName;
                tb_CustomerPhone.Text = targetCusInfo.strCustomerPhone;

                Button_Delete.Visible = true;
                Button_Save.Visible = true;
                TabOptionWebControls1.SelectIndex = 1;

            }
            else{
                ClientScript.RegisterStartupScript(this.GetType(), "", "<script type='text/javascript'>alert('传给网页的参数不是整数！');</script>");
            }
        }

        void Button_Save_Click(object sender, EventArgs e)
        {
            int RecordCount = 0;
            Customer_Info catchKeyWord = new Customer_Info();
            catchKeyWord.strCustomerName = tb_CustomerName.Text.ToString();
            catchKeyWord.strCustomerPhone = tb_CustomerPhone.Text.ToString();
            int ID = Convert.ToInt32(_intCustomerID);
            SqlDataProvider_sample.Instance().Keywords_Save(ID,catchKeyWord);
            BindData();
            this.AspNetPager1.RecordCount = RecordCount;
            TabOptionWebControls1.SelectIndex = 0;
        }

        void Button_Delete_Click(object sender, EventArgs e)
        {
            int RecordCount = 0;
            Customer_Info catchKeyWord = new Customer_Info();
            int ID = Convert.ToInt32(_intCustomerID);
            SqlDataProvider_sample.Instance().Keywords_Delete(ID);
            BindData();
            this.AspNetPager1.RecordCount = RecordCount;
            TabOptionWebControls1.SelectIndex = 0;
        }

        void Button_SaveNew_Click(object sender, EventArgs e)
        {
            int RecordCount = 0;
            Customer_Info catchKeyWord = new Customer_Info();
            catchKeyWord.strCustomerName = tb_CustomerName.Text.ToString();
            catchKeyWord.strCustomerPhone = tb_CustomerPhone.Text.ToString();
            SqlDataProvider_sample.Instance().Keywords_SaveNew(catchKeyWord);
            BindData();
            this.AspNetPager1.RecordCount = RecordCount;
            TabOptionWebControls1.SelectIndex = 0;
        }

        #endregion

        #region 查询结果排序
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (Orderfld == e.SortExpression)
            {
                if (orderType == 0)
                {
                    orderType = 1;
                }
                else
                {
                    orderType = 0;
                }
            }
            Orderfld = e.SortExpression;
            BindData();
        }

        /// <summary>
        /// 排序字段
        /// </summary>
        public string Orderfld
        {
            get
            {
                if (ViewState["sortOrderfld"] == null)

                    ViewState["sortOrderfld"] = "";

                return (string)ViewState["sortOrderfld"];
            }
            set
            {
                ViewState["sortOrderfld"] = value;
            }
        }

        /// <summary>
        /// 排序类型 1:降序 0:升序
        /// </summary>
        public int orderType
        {

            get
            {

                if (ViewState["sortOrderType"] == null)
                    ViewState["sortOrderType"] = 1;

                return (int)ViewState["sortOrderType"];

            }

            set { ViewState["sortOrderType"] = value; }

        }
        /// <summary>
        /// 排序事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                foreach (TableCell var in e.Row.Cells)
                {
                    if (var.Controls.Count > 0 && var.Controls[0] is LinkButton)
                    {
                        string Colume = ((LinkButton)var.Controls[0]).CommandArgument;
                        if (Colume == Orderfld)
                        {

                            LinkButton l = (LinkButton)var.Controls[0];
                            l.Text += string.Format("<img src='{0}' border='0'>", (orderType == 0) ? Page.ResolveUrl("~/Manager/images/sort_asc.gif") : Page.ResolveUrl("~/Manager/images/sort_desc.gif"));
                            //Image Img = new Image();
                            //SortDirection a = GridView1.SortDirection;
                            //Img.ImageUrl = (a == SortDirection.Ascending) ? "i_p_sort_asc.gif" : "i_p_sort_desc.gif";
                            //var.Controls.Add(Img);
                        }
                    }
                }
            }
        }
        #endregion
    }

}