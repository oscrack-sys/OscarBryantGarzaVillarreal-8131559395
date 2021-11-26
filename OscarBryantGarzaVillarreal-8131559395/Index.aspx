<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OscarBryantGarzaVillarreal_8131559395.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
    <style>
        tr:hover{
            background-color: rgba(143,151,121,0.20);
            color:black;
        }
    </style>
</head>
<body>
    <div class="container">
       
        <br />
    <form class="" id="form1" runat="server">
        <div class="card shadow p-3 mb-5 bg-white rounded">
            <div class="card-header"><h4>Ingrese su informaci&oacute;n</h4></div>
            <br />
            <div class="form-group">
            <asp:Label ID="lblOutput" 
                     Text="RFC: " 
                     runat="server"
                     AssociatedControlID="TextBox1"/>
            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox1" Display="Static" ErrorMessage="Información invalida" 
                ValidationExpression="^([A-Z,Ñ,&]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[A-Z|\d]{3})$">
            </asp:RegularExpressionValidator>
            <asp:TextBox Font-Names="rfc" CssClass="form-control" ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label1" 
                     Text="Razón: " 
                     runat="server"
                     AssociatedControlID="TextBox2"/>
            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox2" Display="Static" ErrorMessage="Información invalida" 
                ValidationExpression="[a-zA-Z .]{2,254}">
            </asp:RegularExpressionValidator>
            <asp:TextBox CssClass="form-control" ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" 
                     Text="Contrase&ntilde;a: " 
                     runat="server"
                     AssociatedControlID="TextBox3"/>
            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox3" Display="Static" ErrorMessage="Debe incluir al menos una letra y un numero." 
                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">
            </asp:RegularExpressionValidator>
            <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server"></asp:TextBox>

           
            <br />
            <asp:Button ID="btn1" Text="Registrar" runat="server" CssClass="btn btn-danger" />
            </div>
        </div>

    </form>

    <input type="button" value="Ver registros" class="btn btn-success"onclick="ver();"/>
        <br />
        <br />

    <div id="tabla1"></div>
        
    


    </div>

    
</body>
<script>

    function ver() {
        //Consumo de api
        $.ajax({
            type: "GET",
            url: "https://jsonplaceholder.typicode.com/users",
            dataType: "json",
            success: function (data) {
                $.each(data, function (i, item) {
                    var row = "<div class='card shadow p-3 mb - 5 bg - white rounded'><table class='table'>" +
                        "<tr><th>Id</th>" +
                        "<td>" + item.id + "</td><td></td></tr>" +
                        "<tr><th>Name</th>" +
                        "<td>" + item.name + "</td><td></td></tr>" +
                        "<tr><th>Username</th>" +
                        "<td>" + item.username + "</td><td></td></tr>" +
                        "<tr><th>Email</th>" +
                        "<td>" + item.email + "</td><td></td></tr>" +
                    "<tr><th rowspan='5'>Address</th>" +
                        "<tr><td>Street:</td><td>" + item.address.street + "</td></tr>" +
                        "<tr><td>Suite:</td><td>" + item.address.suite + "</td></tr>" +
                        "<tr><td>City:</td><td>" + item.address.city + "</td></tr>" +
                        "<tr><td>Zip code:</td><td>" + item.address.zipcode + "</td></tr>" +
                    "</tr > " +
                        "<tr><th rowspan='3'>Geo</th>" +
                        "<tr><td>Lat:</td><td>" + item.address.geo.lat + "</td></tr>" +
                        "<tr><td>Lng:</td><td>" + item.address.geo.lng + "</td></tr>" +
                        "</tr > " +
                        "<tr><th>Phone</th>" +
                        "<td>" + item.phone + "</td><td></td></tr>" +
                        "<tr><th>Website</th>" +
                        "<td>" + item.website + "</td><td></td></tr>" +
                        "<tr><th rowspan='4'>Company</th>" +
                        "<tr><td>Copany name:</td><td>" + item.company.name + "</td></tr>" +
                        "<tr><td>CatchPhrase:</td><td>" + item.company.catchPhrase + "</td></tr>" +
                        "<tr><td>Bs:</td><td>" + item.company.bs + "</td></tr>" +
                        "</tr > " +
                    "</table></div><br>"
                    $("#tabla1").append(row);
                });
            }, //End of AJAX Success function  
        });
    }; 

</script>
</html>
