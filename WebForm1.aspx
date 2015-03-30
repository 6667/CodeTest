<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/MasterPage/PageTemplate.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="FrameWork.web.Manager.Module.AspTest.CodeTest.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <FrameWorkWebControls:HeadMenuWebControls ID="webcontrols1" runat="server" HeadOPTxt="购物查询" HeadTitleTxt="购物页面" ></FrameWorkWebControls:HeadMenuWebControls>
    <FrameWorkWebControls:TabOptionWebControls ID="tabcontrols1" runat="server">
        <FrameWorkWebControls:TabOptionItem ID="tabitem1" runat="server"><table width="100%" border="0" cellspacing="1" cellpadding="4" align="center"><tr><td class="table_body_NoWidth" style="width: 19%">客户ID</td><td style="width: 267px" ><asp:TextBox ID="CustomerID"  runat="server"  Columns="20" CssClass="text_input">
                      </asp:TextBox></td><td style="width: 213px">产品 </td>
            <td>
                <asp:DropDownList runat="server" ID="menu">
                    
                </asp:DropDownList>
                
                </td></tr><tr>
                    <td colspan="4" align="right">
                        <asp:Button ID="Button_Buy" runat="server" CssClass="button_bak" Text="购买" />

                    </td></tr><tr><td>
                        <asp:GridView ID="view" runat="server"  Width="550%" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField SortExpression="Product_Name" HeaderText="序号" DataField="num" />
                                <asp:BoundField SortExpression="Amount" HeaderText="商品名称" DataField="strProductName" />
                                <asp:BoundField SortExpression="Date" HeaderText="购买时间" DataField="strTime" />

                            </Columns>

                        </asp:GridView>

                                  </td></tr></table>

        </FrameWorkWebControls:TabOptionItem>
    </FrameWorkWebControls:TabOptionWebControls>
</asp:Content>
