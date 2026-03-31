<%
    // Invalidate session
    session.invalidate();
%>
<script>
    alert("You have been logged out successfully!");
    window.location.href = "login.jsp"; // Redirect after user clicks "OK"
</script>
