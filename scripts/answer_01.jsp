<%@ page import="java.io.*, java.net.*, org.json.*" %>

<%

out.println("
<!DOCTYPE html>
<html>
    <head>
        <title>MDM Demo</title> 
        <!--[if lt IE 9]>
        <script src='//html5shiv.googlecode.com/svn/trunk/html5.js'></script>
        <![endif]-->
    </head>

    <style>
        table {
            width: auto;
            border: 2px solid black;
        }
        th {
            height: 50px; 
            text-align: left;
        }
        td {            
            width: 100px;
        }
        tr:nth-child(even) {
            background: #CCC;
        }
        tr:nth-child(odd) {
            background: #FFF;
        }
    </style>

<body>
    <section id='main'>
       ");


try {
    String apiUrl = "http://127.0.0.1:8000/employees/?format=json";
    HttpURLConnection connection = (HttpURLConnection) new URL(apiUrl).openConnection();
    connection.setRequestMethod("GET");

    if (connection.getResponseCode() == 200) {
        String response = new BufferedReader(new InputStreamReader(connection.getInputStream()))
            .lines().reduce("", (acc, line) -> acc + line);

        JSONArray employees = new JSONArray(response);

        out.println("<table><tr>"
            + "<th>First Name</th>"
            + "<th>Last Name</th>"
            + "<th>Title</th>"
            + "<th>Age</th>" + "<th>Status</th>"
            + "</tr>)";

        for (int i = 0; i < employees.length(); i++) {

            JSONObject employee = employees.getJSONObject(i);

            out.println("<tr>";
            out.println("<td>" + employee.getString("firstname") + "</td>");
            out.println("<td>" + employee.getString("lastname") + "</td>");
            out.println("<td>" + employee.getString("title") + "</td>");
            out.println("<td>" + employee.getInt("age") + "</td>");
            out.println("<td>" + employee.getString("status") + "</td>");
            out.println("</tr>";
        }

        out.println("</table>";

    } else {
        out.println("Failed to fetch data. HTTP error code: " + connection.getResponseCode());
    }
    connection.disconnect();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}

out.println("</section>";
out.println("</body>";
out.println("</html>";



%>
