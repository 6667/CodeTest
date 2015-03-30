<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/MasterPage/PageTemplate.Master" AutoEventWireup="true" CodeBehind="CustomerInfo.aspx.cs" Inherits="FrameWork.web.Manager.Module.AspTest.CodeTest.CustomerInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
        <script src="../../../js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../../../js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
    <link href="../../../js/jquery-ui-1.10.3.custom/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet" />

        <link rel="stylesheet" type="text/css" href="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/css/subModal.css" />

    <script type="text/javascript" src="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/js/common.js"></script>

    <script type="text/javascript" src="<%=Page.ResolveUrl("~/") %>Manager/inc/FineMessBox/js/subModal.js"></script>
    <script src="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
    <link href="<%=Page.ResolveUrl("~/") %>Manager/js/jquery-ui-1.10.3.custom/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet" />

    <FrameWorkWebControls:HeadMenuWebControls ID="HeadMenuWebControls1" runat="server" HeadOPTxt="顾客信息维护" HeadTitleTxt="顾客信息维护" HeadHelpTxt="点击顾客名称查看详细页" ButtonList-Capacity="4">
    </FrameWorkWebControls:HeadMenuWebControls>        
    <FrameWorkWebControls:TabOptionWebControls ID="TabOptionWebControls1" runat="server">
        <FrameWorkWebControls:TabOptionItem ID="TabOptionItem1" runat="server" Tab_Name="顾客信息查询">
        <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
		<tr>
			<td class="table_body table_body_NoWidth" >
                客户姓名</td>
			<td class="table_none table_none_NoWidth" >
                <asp:TextBox ID="TextBox_CustomerName"  runat="server"  Columns="20" CssClass="text_input">
                </asp:TextBox></td>
			<td class="table_body table_body_NoWidth" >
                客户电话</td>
			<td class="table_none table_none_NoWidth" >
                <asp:TextBox ID="TextBox_CustomerPhone" runat="server" Columns="20" CssClass="text_input">
                </asp:TextBox></td>         
		</tr>
            
            
            <tr>
                <td colspan="4" align="right">
                    <asp:Button ID="Button_Search" runat="server" CssClass="button_bak" Text="查询" />
                </td>
            </tr>

            <tr>
                <td colspan="4">
                    <div>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" OnSorting="GridView1_Sorting" OnRowCreated="GridView1_RowCreated">
                            <Columns>
                                <asp:BoundField SortExpression="CustomerID" HeaderText="顾客编号" DataField="intCustomerID" />
                                <asp:BoundField SortExpression="CustomerName" HeaderText="顾客姓名" DataField="strCustomerName" />
                                <asp:BoundField SortExpression="CustomerPhone" HeaderText="顾客手机号码" DataField="strCustomerPhone" />

                                <asp:TemplateField HeaderText="详细">
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" OnClick="Button_Operation_Click" Text='详情' CommandArgument='<%#Eval("intCustomerID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <FrameWorkWebControls:AspNetPager ID="AspNetPager1" runat="server" OnPageChanged="AspNetPager1_PageChanged">
                        </FrameWorkWebControls:AspNetPager>
                    </div>
                </td>
            </tr>
		</table>
        </FrameWorkWebControls:TabOptionItem>
        <FrameWorkWebControls:TabOptionItem ID="TabOptionItem2" runat="server" Tab_Name="顾客新建/维护">
            <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                <tr>
                    <td class="table_title" colspan="4">
                        <asp:Label ID="Title_Txt" runat="server" Text="详细"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="table_body table_body_NoWidth" >
                    顾客名称</td>
			        <td class="table_none table_none_NoWidth" >
                    <asp:TextBox ID="tb_CustomerName" runat="server" Columns="20" CssClass="text_input">
                    </asp:TextBox></td>
			        <td class="table_body table_body_NoWidth" >
                    顾客电话</td>
			        <td class="table_none table_none_NoWidth" >
                    <asp:TextBox ID="tb_CustomerPhone" runat="server" Columns="20" CssClass="text_input">
                    </asp:TextBox></td>   
               </tr>

               <tr>
                   <td colspan="4" align="right">
                       <div>
                           <asp:Button ID="Button_Save" runat="server" CssClass="button_bak" Text="保存" />&nbsp;
                           <asp:Button ID="Button_SaveNew" runat="server" CssClass="button_bak" Text="另存为新"/>&nbsp;
                           <asp:Button ID="Button_Delete" runat="server" CssClass="button_bak" Text="删除"/>
                       </div>
                   </td>
               </tr>
            </table>
        </FrameWorkWebControls:TabOptionItem>
    </FrameWorkWebControls:TabOptionWebControls> 
</asp:Content>
