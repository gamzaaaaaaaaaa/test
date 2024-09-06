<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.domain.product"%>
<%@ page import="com.springmvc.domain.product_ingredient"%>
<%
    // 카테고리
    String category = request.getParameter("category");
    System.out.println(category);

    // 제품 리스트
    List<product> productDetailsList = (List<product>) request.getAttribute("productDetails");
    System.out.println(productDetailsList);

    int totalRecords = ((Integer) request.getAttribute("totalRecords")).intValue();
    System.out.println(totalRecords);

    int pageNum = 0;
    pageNum = ((Integer) request.getAttribute("pageNum")).intValue();

    if (pageNum == 0) {
        pageNum = 1;
    }
    System.out.println(pageNum);

    int limit = ((Integer) request.getAttribute("limit")).intValue();
    System.out.println(limit);

    int totalPages = (totalRecords + limit - 1) / limit;
    System.out.println(totalPages);
%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/product_list.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>상품 목록</title>
</head>

<body>
<div>
    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 rounded-3 outer-container">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">우리 아이가 믿고 쓸 수 있는 안전한 제품</h1>
            <p class="col-md-8 fs-4 subtitle">엄마의 정성으로 선택한, 아이를 위한 최상의 선택</p>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/ibom/product/list?category=all&pageNum=1">전체보기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/ibom/product/list?category=lotion&pageNum=1">로션</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/ibom/product/list?category=sun&pageNum=1">선케어</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <div class="text-end mb-3">
                <span class="badge btn-custom">전체 <%= totalRecords %>건</span>
            </div>
            
            <%
            if (productDetailsList.isEmpty()) {
                out.println("<p>해당 카테고리에 상품이 없습니다.</p>");
            } 
            for (product item : productDetailsList) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card" onclick="location.href='/ibom/product/productDetail/<%= item.getProduct_id() %>';">
                    <img src="/ibom/resources/images/<%= item.getImage() %>" class="card-img-top" alt="<%= item.getName() %>">
                    <div class="card-body text-center">
                        <p class="card-text"><%= item.getBrand() %></p>
                        <h5 class="card-title"><%= item.getName() %></h5>
                        <p class="card-text"><%= item.getPrice() %> 원</p>
                        <a href="/ibom/product/productDetail/<%= item.getProduct_id() %>" class="btn">자세히 보기</a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <div class="text-center">
        <div class="pagination">
            <%
                if (totalPages > 0) {
                    for (int i = 1; i <= totalPages; i++) {
            %>
            <a href="/ibom/product/list?pageNum=<%= i %>&category=<%= category %>" class="<%= (pageNum == i) ? "active" : "" %>">
                <%= i %>
            </a>
            <%
                    }
                } else {
            %>
            <span>페이지가 없습니다.</span>
            <%
                }
            %>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
