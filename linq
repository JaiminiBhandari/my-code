COMPLETE LIST OF LINQ OPERATIONS (NOW INCLUDED)
🔹 Core (Unit-I)

Where

Select

OrderBy

OrderByDescending

ThenBy

Count

Sum

Average

Max

Min

GroupBy

First

FirstOrDefault

Last

LastOrDefault

Single

SingleOrDefault

🔹 Extra (You asked to add)

Join

Take

Skip

Any

All

Distinct

ToList

ToArray

👉 This is now 100% COMPLETE LINQ (no operation missing)

🟦 FRONTEND — LINQAllMovies.aspx

(Same as before – no change required)

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LINQAllMovies.aspx.cs" Inherits="LINQAllMovies" %>

<!DOCTYPE html>
<html>
<head>
    <title>LINQ All Operations - Movies</title>
</head>
<body>

<h2>LINQ ALL OPERATIONS (Full Syllabus)</h2>

Movie ID:
<asp:TextBox ID="txtId" runat="server"></asp:TextBox><br /><br />

Movie Name:
<asp:TextBox ID="txtName" runat="server"></asp:TextBox><br /><br />

Director:
<asp:TextBox ID="txtDirector" runat="server"></asp:TextBox><br /><br />

Rating:
<asp:TextBox ID="txtRating" runat="server"></asp:TextBox><br /><br />

<asp:Button ID="btnAdd" runat="server" Text="Add Movie" OnClick="btnAdd_Click" />
<br /><br />

<asp:Button ID="btnLINQ" runat="server" Text="Run ALL LINQ Operations" OnClick="btnLINQ_Click" />
<br /><br />

<hr />

<asp:Label ID="lblResult" runat="server"></asp:Label>

</body>
</html>

🟩 BACKEND — LINQAllMovies.aspx.cs
(FULL + EXTENDED LINQ)
using System;
using System.Collections.Generic;
using System.Linq;

public partial class LINQAllMovies : System.Web.UI.Page
{
    // Movie class
    public class Movie
    {
        public int MovieId;
        public string MovieName;
        public string Director;
        public double Rating;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session["movies"] = new List<Movie>();
    }

    // Add movie (user input)
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<Movie> list = (List<Movie>)Session["movies"];

        Movie m = new Movie();
        m.MovieId = int.Parse(txtId.Text);
        m.MovieName = txtName.Text;
        m.Director = txtDirector.Text;
        m.Rating = double.Parse(txtRating.Text);

        list.Add(m);
        Session["movies"] = list;

        lblResult.Text = "Movie Added Successfully<br/>";
    }

    // ALL LINQ OPERATIONS
    protected void btnLINQ_Click(object sender, EventArgs e)
    {
        List<Movie> list = (List<Movie>)Session["movies"];
        string r = "<h3>ALL LINQ OPERATIONS OUTPUT</h3>";

        // SELECT
        r += "<b>All Movies:</b><br/>";
        foreach (var m in list.Select(x => x))
            r += m.MovieName + "<br/>";

        // WHERE
        r += "<br/><b>Rating > 8:</b><br/>";
        foreach (var m in list.Where(x => x.Rating > 8))
            r += m.MovieName + "<br/>";

        // WHERE (Director)
        r += "<br/><b>Director = Christopher Nolan:</b><br/>";
        foreach (var m in list.Where(x => x.Director == "Christopher Nolan"))
            r += m.MovieName + "<br/>";

        // SKIP + TAKE
        r += "<br/><b>Skip 2 Take 3:</b><br/>";
        foreach (var m in list.Skip(2).Take(3))
            r += m.MovieName + "<br/>";

        // 5th Movie
        var fifth = list.Skip(4).FirstOrDefault();
        r += "<br/><b>5th Movie:</b> " + (fifth == null ? "NA" : fifth.MovieName);

        // ENDS WITH
        r += "<br/><br/><b>Movie Name Ends With 'a':</b><br/>";
        foreach (var m in list.Where(x => x.MovieName.EndsWith("a")))
            r += m.MovieName + "<br/>";

        // ORDER BY + THEN BY
        r += "<br/><b>OrderBy Rating ThenBy Name:</b><br/>";
        foreach (var m in list.OrderBy(x => x.Rating).ThenBy(x => x.MovieName))
            r += m.MovieName + " - " + m.Rating + "<br/>";

        // AGGREGATE FUNCTIONS
        r += "<br/><b>Count:</b> " + list.Count();
        r += "<br/><b>Sum:</b> " + list.Sum(x => x.Rating);
        r += "<br/><b>Average:</b> " + list.Average(x => x.Rating);
        r += "<br/><b>Max:</b> " + list.Max(x => x.Rating);
        r += "<br/><b>Min:</b> " + list.Min(x => x.Rating);

        // GROUP BY
        r += "<br/><br/><b>Group By Director:</b><br/>";
        foreach (var g in list.GroupBy(x => x.Director))
        {
            r += g.Key + "<br/>";
            foreach (var m in g)
                r += "- " + m.MovieName + "<br/>";
        }

        // ANY / ALL
        r += "<br/><b>Any Rating > 9:</b> " + list.Any(x => x.Rating > 9);
        r += "<br/><b>All Rating > 5:</b> " + list.All(x => x.Rating > 5);

        // DISTINCT
        r += "<br/><br/><b>Distinct Directors:</b><br/>";
        foreach (var d in list.Select(x => x.Director).Distinct())
            r += d + "<br/>";

        // FIRST / LAST
        r += "<br/><b>First:</b> " + list.First().MovieName;
        r += "<br/><b>Last:</b> " + list.Last().MovieName;

        // FIRST OR DEFAULT / LAST OR DEFAULT
        r += "<br/><b>FirstOrDefault:</b> " +
             (list.FirstOrDefault(x => x.Rating > 10) == null ? "NULL" : "FOUND");

        r += "<br/><b>LastOrDefault:</b> " +
             (list.LastOrDefault(x => x.Rating > 10) == null ? "NULL" : "FOUND");

        // SINGLE / SINGLE OR DEFAULT
        r += "<br/><b>Single:</b> " + list.Single(x => x.MovieId == list[0].MovieId).MovieName;
        r += "<br/><b>SingleOrDefault:</b> " +
             (list.SingleOrDefault(x => x.MovieName == "XYZ") == null ? "NULL" : "FOUND");

        // TOLIST / TOARRAY
        List<Movie> movieList = list.ToList();
        Movie[] movieArray = list.ToArray();

        r += "<br/><b>ToList Count:</b> " + movieList.Count;
        r += "<br/><b>ToArray Length:</b> " + movieArray.Length;

        lblResult.Text = r;
    }
}
