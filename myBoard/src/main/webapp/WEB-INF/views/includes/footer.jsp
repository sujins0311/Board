<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery 주석처리 -->
<!--     <script src="/resources/vendor/jquery/jquery.min.js"></script> -->

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
  $(document).ready(function() {
    $('#dataTables-example').DataTable({
      responsive: true
    });
    $(".sidebar-nav")
      .attr("class","sidebar-nav navbar-collapse collapse")
      .attr("aria-expanded",'false')
      .attr("style","height:1px");
  });
</script>
<style>
.footer {
	height:100px; 
	display: flex; 
	align-items: center; 
	justify-content:center; 
	flex-direction: column-reverse; 
	background-color:aliceblue;
}
</style>

<body>
<div class="footer" style="border-top: solid 1px #88b8ff;">
	<p>Copyright © 2024 SJ. All Rights Reserved.</p>
	<div>
		<a href="https://github.com/sujins0311/sujins0311" target="_blank">
			<img src="/resources/images/github-mark.svg" style="width:25px"/>
		</a>
		<a href="https://sujinpad.tistory.com" target="_blank">
			<img src="/resources/images/tistory-mark.svg" style="width:33px"/>
		</a>
 	</div>
</div>
</body>

</html>