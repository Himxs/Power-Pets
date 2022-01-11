<%@ page import="com.mygroup.powerpets.domain.User" %>
<%@ page import="com.mygroup.powerpets.persistence.impl.ProjectDaoImpl" %><%--
  Author: Kwanho
  Date: 2021/11/20
  Time: 10:13
--%>
<%@ include file="../common/header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: Kwanho
  Date: 2021/11/19
  Time: 14:38
--%>
<%--
  shitmountain
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <!-- CSS引入 -->
    <link rel="stylesheet" href="static/css/powerpets.css"/>

    <%-- Javascript引入 --%>
    <%-- jqurey --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>

    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>电力宠物 - PowerPets</title>
    <script>
        console.log("111");
        var xhr;

        function search(word) {
            console.log(word);
            var searchText = word;
            xhr = new XMLHttpRequest();
            xhr.onreadystatechange = process;
            xhr.open("GET", "main?action=searchAction&searchText=" + searchText, true);
            xhr.send(null);
        }

        function process() {
            console.log("113");
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    console.log("114");

                    var $deleteli = $('li');
                    $deleteli.remove();

                    var msg = xhr.responseText;
                    console.log("msg" + msg);
                    console.log(msg.length);
                    if (msg.length < 1) {
                        console.log("xiaoyu1")
                        var $newul = $('<li>没有这样的宠物呢</li>');
                        $('ul').append($newul);
                    } else {
                        console.log("dayuyi")
                        var pro = "";
                        for (i = 0; i <= msg.length - 1; i++) {
                            if (msg.charAt(i) == '*') {
                                var $newul = $('<li>' + pro + '</li>');
                                $('ul').append($newul);
                                pro = "";
                            } else {
                                pro = pro + msg.charAt(i);
                            }
                        }

                        $("#Search-Automatic-Completion").show();

                        $(function () {
                            var $listItems = $('li');
                            var $ulItem = $('ul');
                            $listItems.on('click', function () {
                                console.log("haha");
                                document.getElementById("search-keywords").value = this.innerHTML;
                                // $ulItem.hidden;
                                $("#Search-Automatic-Completion").hide();
                            });
                        });
                    }
                }
            }
        }

        $(function () {
            var $listItems = $('li');
            $listItems.on('click', function () {
                console.log("haha");
                document.getElementById("search-keywords").value = this.innerHTML;
            });
        });
    </script>
</head>
<body>
<div class="wrapper">
    <div class="topBar">
        <div class="topBar-left">
            <div class="Logo">
                <a href="main"><img width="70px" height="70px" align="middle" src="static/images/PageLogo.png"
                                    alt="logo"/></a>
            </div>

            <div class="Title">
                <h1 id="title-text" style="font-size:32px;margin-top:20px;">Power-Pets</h1>
            </div>

            <div class="Search">
                <form action="main" method="post">
                    <label>
                        <input type="text" name="keywords" id="search-keywords" value="" class="keywords"
                               placeholder="在此处搜索您想要的宠物……" onkeyup="search(this.value);">
                        <input type="submit" value="🔍" id="searchBtn">
                    </label>
                </form>
            </div>
            <div class="Search-Automatic-Completion" id="Search-Automatic-Completion">
                <ul class="ul" id="ul">
                </ul>
            </div>
        </div>
        <div class="topBar-right">
            <div class="MenuContent">
                <a href="cart?action=view&userID=${sessionScope.user.id}">
                    <text style="font-family: var(--font-family-sans-serif);">🛒</text>
                </a>
                <img align="middle" src="static/images/separator.gif"/>
                <c:if test="${sessionScope.user == null}">
                    <a href="login">登录</a>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <c:if test="${sessionScope.isLogin.equals(\"false\")||sessionScope.isLogin == null}">
                        <a href="login">登录</a>
                    </c:if>
                </c:if>
                <c:if test="${sessionScope.user != null}">
                    <c:if test="${sessionScope.isLogin.equals(\"true\")}">
                        <a href="account?action=sign-out">
                            <text style="color:var(--danger);">注销</text>
                        </a>
                        <img align="middle" src="static/images/separator.gif"/>
                        <a href="account?action=view">${sessionScope.user.username}</a>
                    </c:if>
                </c:if> <img align="middle" src="static/images/separator.gif"/>
                <a href="https://github.com/Kwanhooo/Power-Pets">?</a>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="navigator" style="top: 17px;">
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-home" onclick="window.location.href ='main'">
                    <img src="static/images/home.png" width="40px" height="40px" style="border-radius: 25px" alt="home">
                </button>
            </div>

            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-home" onclick="window.location.href ='account?action=view'">
                    <img src="static/images/me.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>

            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-home"
                        onclick="window.location.href ='cart?action=view&userID=${sessionScope.user.id}'">
                    <img src="static/images/cart.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
            <hr style="width:40px;margin-top: 20px;">
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-dog"
                        onclick="window.location.href ='category?categoryName=DOGS'">
                    <img src="static/images/dog.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-cat"
                        onclick="window.location.href ='category?categoryName=CATS'">
                    <img src="static/images/cat.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-bird"
                        onclick="window.location.href ='category?categoryName=BIRDS'">
                    <img src="static/images/bird.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-pig"
                        onclick="window.location.href ='category?categoryName=PIG'">
                    <img src="static/images/pig.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
            <div class="navigator-item">
                <button class="navigator-btn navigator-btn-others"
                        onclick="window.location.href ='category?categoryName=OTHERS'">
                    <img src="static/images/others.png" width="40px" height="40px" style="border-radius: 25px">
                </button>
            </div>
        </div>
        <div class="category">
            <div class="dog">
                <div class="categoryCount">
                    ${sessionScope.dogsAmount}
                </div>
                <div class="categoryTitle">Dogs</div>
                <div class="categoryDescription">可爱的小狗勾</div>
                <hr style="width:480px">
                <a href="category?categoryName=DOGS">
                    <button class="categoryButton" id="dogBtn">看看我</button>
                </a>
            </div>
            <div class="cat">
                <div class="categoryCount">
                    ${sessionScope.catsAmount}
                </div>
                <div class="categoryTitle">Cats</div>
                <div class="categoryDescription">可爱的小猫咪</div>
                <hr style="width:480px">
                <a href="category?categoryName=CATS">
                    <button class="categoryButton" id="catBtn">看看我</button>
                </a>
            </div>
            <div class="bird">
                <div class="categoryCount">
                    ${sessionScope.birdsAmount}
                </div>
                <div class="categoryTitle">Birds</div>
                <div class="categoryDescription">可爱的鸟鸟</div>
                <hr style="width:480px">
                <a href="category?categoryName=BIRDS">
                    <button class="categoryButton" id="birdBtn">看看我</button>
                </a>
            </div>
            <div class="pig">
                <div class="categoryCount">
                    ${sessionScope.pigsAmount}
                </div>
                <div class="categoryTitle">Pigs</div>
                <div class="categoryDescription">可爱的小猪猪</div>
                <hr style="width:480px">
                <a href="category?categoryName=PIG">
                    <button class="categoryButton" id="pigBtn">看看我</button>
                </a>
            </div>

            <div class="others">
                <div class="othersTitle">Others</div>
                <div class="othersDescription">
                    <text style="font-family: 'Cascadia Code', Courier, mono, serif ;font-size: 20px; font-weight: bold;">
                        ${sessionScope.othersAmount}
                    </text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    奇奇怪怪的宠物&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="category?categoryName=OTHERS">
                        <button class="othersBtn">看看我</button>
                    </a>
                </div>
            </div>
        </div>

        <div class="itemDisplay">
            <div class="statistics">
                <div class="statistics-left">
                    <p style="font-style: italic;color: grey">
                        我们的会员数
                    </p>
                    <h1>
                        ${sessionScope.userAmount}
                    </h1>
                </div>
                <div class="statistics-right">
                    <p style="font-style: italic;color: grey">
                        在售宠物
                    </p>
                    <h1>${sessionScope.itemsAmount}</h1>
                </div>

            </div>

            <div class="items">
                <hr style="width: 400px">

                <h1 style="margin-left: 30px">热销中</h1>

                <%--从这里开始插入展示宠物--%>
                <div class="item">
                    <img src="static/images/hashiqi.png" width="100px" height="100px" style="border-radius: 50px">
                    <a href="project?projectName=哈士奇"><p style="font-weight: bold; font-size:23px;color:#007BFF">哈士奇</p>
                    </a>
                    <p>
                        <%
                            ProjectDaoImpl projectDaoImpl = new ProjectDaoImpl();
                            out.println(projectDaoImpl.selectByProject("哈士奇").getProjectDescription());
                        %>
                    </p>
                </div>
                <hr style="width: 400px">

                <div class="item">
                    <img src="static/images/yingduan.png" width="100px" height="100px" style="border-radius: 50px">
                    <a href="project?projectName=英短"><p style="font-weight: bold; font-size:23px;color:#007BFF">英短</p>
                    </a>
                    <p>
                        <%
                            out.println(projectDaoImpl.selectByProject("英短").getProjectDescription());
                        %>
                    </p>
                </div>
                <hr style="width: 400px">
            </div>

        </div>
    </div>

<%@ include file="../common/bottom.jsp" %>