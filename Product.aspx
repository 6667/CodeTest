
<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/MasterPage/PageTemplate.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="FrameWork.web.Manager.Module.AspTest.CodeTest.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script src="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
    <link href="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet" />
    <script src="<%=Page.ResolveClientUrl("~/")%>Manager/js/datePicker/WdatePicker.js" type="text/javascript"></script>

        <link rel="stylesheet" type="text/css" href="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/css/subModal.css" />

    <script type="text/javascript" src="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/js/common.js"></script>

    <script type="text/javascript" src="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/js/subModal.js"></script>
    <FrameWorkWebControls:HeadMenuWebControls ID="HeadMenuWebControls1" runat="server" HeadOPTxt="顾客信息维护" HeadTitleTxt="客户购物记录" HeadHelpTxt= ButtonList-Capacity="4">
    </FrameWorkWebControls:HeadMenuWebControls>        
    <FrameWorkWebControls:TabOptionWebControls ID="TabOptionWebControls1" runat="server">
        <FrameWorkWebControls:TabOptionItem ID="TabOptionItem1" runat="server" Tab_Name="顾客信息查询">
        <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
		<tr>
			<td class="table_body table_body_NoWidth" >
                客户ID</td>
			<td class="table_none_NoWidth" style="width: 27%" >
                <asp:TextBox ID="CustomerID"  runat="server"  Columns="20" CssClass="text_input">
                </asp:TextBox></td>
			<td class="table_body table_body_NoWidth" >
                <asp:TextBox ID="TextBox_dtStart" title="请输入开始日期" onfocus="WdatePicker({isShowClear:false,readOnly:true});" runat="server" Columns="10" CssClass="text_input"></asp:TextBox></td> 
            
			<td class="table_none_NoWidth" style="width: 22%" >
                <asp:TextBox ID="TextBox_dtEnd" title="请输入开始日期" onfocus="WdatePicker({isShowClear:false,readOnly:true});" runat="server" Columns="10" CssClass="text_input" Width="91px"></asp:TextBox></td> 
            <td class="table_body table_body_NoWidth" >
                总计</td>
			<td class="table_none table_none_NoWidth" >
                <asp:TextBox ID="TextBox1"  runat="server"  Columns="20" CssClass="text_input" Width="126px"></asp:TextBox></td>   
		</tr>
            
            
            <tr>
                <td colspan="6" align="right">
                    <asp:Button ID="Button_Search" runat="server" CssClass="button_bak" Text="查询" />
                </td>
            </tr>

            <tr>
                <td colspan="6">
                    <div style="width: 946px">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="115%" OnSorting="GridView1_Sorting" OnRowCreated="GridView1_RowCreated">
                            <Columns>
                                <asp:BoundField SortExpression="Product_Name" HeaderText="商品名称" DataField="strProductName" />                                
                                <asp:BoundField SortExpression="Amount" HeaderText="购买数量" DataField="intAmount" />
                                <asp:BoundField SortExpression="Date" HeaderText="购买日期" DataField="strTime" />
                            </Columns>
                        </asp:GridView>
                        <FrameWorkWebControls:AspNetPager ID="AspNetPager1" runat="server" OnPageChanged="AspNetPager1_PageChanged">
                        </FrameWorkWebControls:AspNetPager>
                    </div>
                </td>
            </tr>
		</table>
        </FrameWorkWebControls:TabOptionItem>
    </FrameWorkWebControls:TabOptionWebControls> 
</asp:Content>
