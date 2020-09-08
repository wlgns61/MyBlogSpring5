<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"   
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="   
	crossorigin="anonymous">
</script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" 
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" 
	crossorigin="anonymous"/>
	
<!-- common CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/common.css" type="text/css"/>

<!--nav bar-->
<nav class="navbar navbar-expand-sm navbar-dark bg-dark" style="margin-bottom: 2%;">
	<a class="navbar-brand" href="#">JIHOON STORY</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	</button>
	
	<div class="collapse navbar-collapse" id="navbarsExample03">
	    <ul class="navbar-nav mr-auto">
	    	<li class="nav-item active">
	      		<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
	    	</li>
	    	<li class="nav-item">
	      		<a class="nav-link" href="#">Q&A</a>
	    	</li>
	    	<li class="nav-item">
	      		<a class="nav-link disabled" href="#">Disabled</a>
	    	</li>
	    	<li class="nav-item dropdown">
	      		<a class="nav-link dropdown-toggle" href="#" id="dropdown03" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
	      		<div class="dropdown-menu" aria-labelledby="dropdown03">
			        <a class="dropdown-item" href="#">Action</a>
			        <a class="dropdown-item" href="#">Another action</a>
			        <a class="dropdown-item" href="#">Something else here</a>
			    </div>
	    	</li>
	  	</ul>
	</div>
</nav>
