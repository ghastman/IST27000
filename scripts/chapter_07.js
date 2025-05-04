{% load staticfiles %}
<!DOCTYPE html>
<html>
    <head>
        <title>MDM Demo</title> 
        <!--[if lt IE 9]>
        <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
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
    <section id="main">
        <table>
            <tr id="resultList">
            </tr>
        </table>
    </section>

    <script src="{% static 'jquery-1.11.3.js' %}" type="text/javascript"></script> 
    <script type="text/javascript">
        $(document).ready(function() {
        "use strict";
        var resultList = $("#resultList");
        resultList.text("This is from JQuery");
        var apiEndPoint = "http://127.0.0.1:8000/employees/?format=json";

        $.get(apiEndPoint)
            .success(function(r) {
                console.log(r.results.length);
                displayResults(r.results);
            })

            .fail(function(err) {
                console.log("Failed to query");    
                //Add custom error message to inform the users.
                resultList.text("Failed to process your search operation, please contact your IT department.");
            })

            .done(function() {
                console.log("API Call completed");            
            });

        function displayResults(results) {
            resultList.empty();

            var title = $("<tr>"
            + "<th>First Name</th>"
            + "<th>Last Name</th>"
            + "<th>Title</th>"
            + "<th>Age</th>" + "<th>Status</th>"
            + "</tr>");

            resultList.append(title);

            $.each(results, function(i, item) {
                var newResult = $("<tr>"
                + "<td>" + item.FirstName + "</td>" + "<td>" + item.LastName + "</td>"
                + "<td>" + item.Title + "</td>"
                + "<td>" + item.Age + "</td>"
                + "<td>" + item.Status + "</td>" + "</tr>");
            
                //if(index=2)
                $(this).css("background-color", "lightgray"); 
                
                //Add honver effects of the display result 
                // /* newResult.hover (function() {
                    // make it darker
                    $(this).css("background-color", "lightgray");
                }, function() {BBB
                // reverse
                    $(this).css("background-color", "transparent");
                });

                resultList.append(newResult);

                });

            }

        });

</script>
</body>
</html>

