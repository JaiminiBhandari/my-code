📘 UNIT – IV : ADO.NET
Assignment Question 9 – Employee Management System

✅ Original Question – NOT CHANGED
✅ Comments Added (Frontend + Backend)

1️⃣ Software & Tools Required (UNCHANGED)
• Visual Studio 2019 / 2022
• .NET Framework 4.8
• MySQL Server
• MySQL Workbench
• NuGet Package: MySql.Data

2️⃣ Database Creation (UNCHANGED + Checkbox Field)
-- Create database
CREATE DATABASE stud_db;

-- Use database
USE stud_db;

-- Create Employee table
CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,          -- Employee ID
    Name VARCHAR(100),              -- Employee Name
    Department_Id INT,              -- Department ID
    Salary DECIMAL(10,2),            -- Employee Salary
    IsActive BOOLEAN                -- Checkbox field (Active/Inactive)
);

3️⃣ Project Creation (UNCHANGED – STEP-BY-STEP)
1. Open Visual Studio
2. File → New → Project
3. Select "ASP.NET Web Application (.NET Framework)"
4. Project Name: EmployeeManagement
5. Framework: .NET Framework 4.8
6. Select Web Forms
7. Click Create

4️⃣ Install MySQL Dependency (COMMENTED)
Tools → NuGet Package Manager → Package Manager Console
Install-Package MySql.Data

Purpose:
MySql.Data provides:
• MySqlConnection
• MySqlCommand
• MySqlDataAdapter

5️⃣ Web.config (COMMENTED – VERY IMPORTANT)
<configuration>

  <!-- Connection string section -->
  <connectionStrings>
    <add name="MySqlConn"
         connectionString="server=localhost;user id=root;password=;database=stud_db"
         providerName="MySql.Data.MySqlClient"/>
  </connectionStrings>

  <!-- Enable debugging and set framework -->
  <system.web>
    <compilation debug="true" targetFramework="4.8" />
  </system.web>

</configuration>

6️⃣ FRONTEND CODE – Employee.aspx
✅ WITH PROPER COMMENTS
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Employee.aspx.cs"
    Inherits="EmployeeManagement.Employee" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Employee Management</title>
</head>
<body>
<form id="form1" runat="server">

<!-- Page Heading -->
<h2>Employee Management System</h2>

<!-- Employee ID input -->
EmpId:
<asp:TextBox ID="txtEmpId" runat="server"></asp:TextBox>
<br /><br />

<!-- Employee Name input -->
Name:
<asp:TextBox ID="txtName" runat="server"></asp:TextBox>
<br /><br />

<!-- Department selection using DropDownList -->
Department:
<asp:DropDownList ID="ddlDept" runat="server">
    <asp:ListItem Text="HR" Value="1" />
    <asp:ListItem Text="IT" Value="2" />
    <asp:ListItem Text="Finance" Value="3" />
</asp:DropDownList>
<br /><br />

<!-- RadioButtons for employment type -->
Employment Type:
<asp:RadioButton ID="rbPerm" runat="server" GroupName="emp" Text="Permanent" />
<asp:RadioButton ID="rbTemp" runat="server" GroupName="emp" Text="Temporary" />
<br /><br />

<!-- ListBox for skills -->
Skills:
<asp:ListBox ID="lstSkills" runat="server" SelectionMode="Multiple">
    <asp:ListItem>C#</asp:ListItem>
    <asp:ListItem>ASP.NET</asp:ListItem>
    <asp:ListItem>MySQL</asp:ListItem>
</asp:ListBox>
<br /><br />

<!-- Checkbox for active employee -->
Is Active:
<asp:CheckBox ID="chkActive" runat="server" Text="Currently Working" />
<br /><br />

<!-- Salary input -->
Salary:
<asp:TextBox ID="txtSalary" runat="server"></asp:TextBox>
<br /><br />

<!-- CRUD operation buttons -->
<asp:Button Text="Insert" runat="server" OnClick="btnInsert_Click" />
<asp:Button Text="Update Salary" runat="server" OnClick="btnUpdate_Click" />
<asp:Button Text="Delete" runat="server" OnClick="btnDelete_Click" />
<br /><br />

<!-- Aggregate and Chapter-4 query buttons -->
<asp:Button Text="Highest Paid Employee" runat="server" OnClick="btnHighest_Click" />
<asp:Button Text="Average Salary" runat="server" OnClick="btnAvg_Click" />
<asp:Button Text="Department Wise Count" runat="server" OnClick="btnDeptCount_Click" />
<br /><br />

<asp:Button Text="Salary > Amount" runat="server" OnClick="btnSalaryGreater_Click" />
<asp:Button Text="Employees by Department" runat="server" OnClick="btnDeptFilter_Click" />
<asp:Button Text="Total Employees" runat="server" OnClick="btnTotalEmp_Click" />
<br /><br />

<asp:Button Text="Min Salary" runat="server" OnClick="btnMinSalary_Click" />
<asp:Button Text="Max Salary" runat="server" OnClick="btnMaxSalary_Click" />
<asp:Button Text="Dept Avg Salary" runat="server" OnClick="btnDeptAvg_Click" />
<br /><br />

<asp:Button Text="Order Salary Asc" runat="server" OnClick="btnOrderAsc_Click" />
<asp:Button Text="Order Salary Desc" runat="server" OnClick="btnOrderDesc_Click" />
<br /><br />

<asp:Button Text="Search By Name" runat="server" OnClick="btnSearchName_Click" />
<asp:Button Text="Check Employee Exists" runat="server" OnClick="btnCheckExists_Click" />
<asp:Button Text="Show Active Employees" runat="server" OnClick="btnActiveEmp_Click" />
<br /><br />

<!-- Label to display results -->
<asp:Label ID="lblResult" runat="server" ForeColor="Blue"></asp:Label>
<br /><br />

<!-- GridView to display employee records -->
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true"></asp:GridView>

</form>
</body>
</html>

7️⃣ BACKEND CODE – Employee.aspx.cs
✅ FULLY COMMENTED (EXAM-READY)
using System;
using System.Data;                          // For DataTable
using MySql.Data.MySqlClient;              // MySQL ADO.NET classes
using System.Configuration;                // To read Web.config

namespace EmployeeManagement
{
    public partial class Employee : System.Web.UI.Page
    {
        // Read connection string from Web.config
        string connStr = ConfigurationManager
                         .ConnectionStrings["MySqlConn"].ConnectionString;

        // Page Load event
        protected void Page_Load(object sender, EventArgs e)
        {
            // Load data only on first load
            if (!IsPostBack)
                LoadData();
        }

        // Common method to load data into GridView
        void LoadData(string q = "SELECT * FROM Employee")
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                // DataAdapter executes SELECT query
                MySqlDataAdapter da = new MySqlDataAdapter(q, conn);

                // DataTable stores records in memory
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind data to GridView
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        // INSERT employee
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string q = "INSERT INTO Employee VALUES(@id,@n,@d,@s,@a)";
                MySqlCommand cmd = new MySqlCommand(q, conn);

                // Passing parameters
                cmd.Parameters.AddWithValue("@id", txtEmpId.Text);
                cmd.Parameters.AddWithValue("@n", txtName.Text);
                cmd.Parameters.AddWithValue("@d", ddlDept.SelectedValue);
                cmd.Parameters.AddWithValue("@s", txtSalary.Text);
                cmd.Parameters.AddWithValue("@a", chkActive.Checked);

                conn.Open();
                cmd.ExecuteNonQuery();       // Execute INSERT
            }
            LoadData();
        }

        // UPDATE salary and active status
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string q = "UPDATE Employee SET Salary=@s, IsActive=@a WHERE EmpId=@id";
                MySqlCommand cmd = new MySqlCommand(q, conn);

                cmd.Parameters.AddWithValue("@s", txtSalary.Text);
                cmd.Parameters.AddWithValue("@a", chkActive.Checked);
                cmd.Parameters.AddWithValue("@id", txtEmpId.Text);

                conn.Open();
                cmd.ExecuteNonQuery();       // Execute UPDATE
            }
            LoadData();
        }

        // DELETE employee
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("DELETE FROM Employee WHERE EmpId=@id", conn);

                cmd.Parameters.AddWithValue("@id", txtEmpId.Text);

                conn.Open();
                cmd.ExecuteNonQuery();       // Execute DELETE
            }
            LoadData();
        }

        // Highest paid employee
        protected void btnHighest_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT Name FROM Employee ORDER BY Salary DESC LIMIT 1", conn);

                conn.Open();
                lblResult.Text = "Highest Paid Employee: " + cmd.ExecuteScalar();
            }
        }

        // Average salary
        protected void btnAvg_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT AVG(Salary) FROM Employee", conn);

                conn.Open();
                lblResult.Text = "Average Salary: " + cmd.ExecuteScalar();
            }
        }

        // Department wise employee count
        protected void btnDeptCount_Click(object sender, EventArgs e)
        {
            LoadData("SELECT Department_Id, COUNT(*) Total FROM Employee GROUP BY Department_Id");
        }

        // Salary greater than given value
        protected void btnSalaryGreater_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee WHERE Salary > " + txtSalary.Text);
        }

        // Filter by department
        protected void btnDeptFilter_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee WHERE Department_Id=" + ddlDept.SelectedValue);
        }

        // Total employee count
        protected void btnTotalEmp_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT COUNT(*) FROM Employee", conn);

                conn.Open();
                lblResult.Text = "Total Employees: " + cmd.ExecuteScalar();
            }
        }

        // Minimum salary
        protected void btnMinSalary_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT MIN(Salary) FROM Employee", conn);

                conn.Open();
                lblResult.Text = "Minimum Salary: " + cmd.ExecuteScalar();
            }
        }

        // Maximum salary
        protected void btnMaxSalary_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT MAX(Salary) FROM Employee", conn);

                conn.Open();
                lblResult.Text = "Maximum Salary: " + cmd.ExecuteScalar();
            }
        }

        // Department average salary
        protected void btnDeptAvg_Click(object sender, EventArgs e)
        {
            LoadData("SELECT Department_Id, AVG(Salary) AvgSalary FROM Employee GROUP BY Department_Id");
        }

        // Order salary ascending
        protected void btnOrderAsc_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee ORDER BY Salary ASC");
        }

        // Order salary descending
        protected void btnOrderDesc_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee ORDER BY Salary DESC");
        }

        // Search employee by name
        protected void btnSearchName_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee WHERE Name LIKE '%" + txtName.Text + "%'");
        }

        // Check employee exists or not
        protected void btnCheckExists_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd =
                    new MySqlCommand("SELECT COUNT(*) FROM Employee WHERE EmpId=@id", conn);

                cmd.Parameters.AddWithValue("@id", txtEmpId.Text);

                conn.Open();
                lblResult.Text =
                    Convert.ToInt32(cmd.ExecuteScalar()) > 0
                    ? "Employee Exists"
                    : "Employee Not Found";
            }
        }

        // Show only active employees
        protected void btnActiveEmp_Click(object sender, EventArgs e)
        {
            LoadData("SELECT * FROM Employee WHERE IsActive=true");
        }
    }
}
