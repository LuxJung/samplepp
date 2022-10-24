<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<!-- <link href="carousel.css" rel="stylesheet"> -->
<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/headers/">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<style>
a { color: #999999;
	text-decoration: none;
}
.newatcl{position: fixed; right: 50px; bottom: 50px; font-size: 50px; width: 60px; height: 60px; background-color: #80d100; 
text-align: center; line-height: 50px; border-radius: 50%;}

      .bd-placeholder-img {font-size: 1.125rem; text-anchor: middle; -webkit-user-select: none; user-select: none;}
      @media (min-width: 768px) {.bd-placeholder-img-lg {font-size: 3.5rem;}}
      .b-example-divider {height: 3rem; background-color: rgba(0, 0, 0, .1); border: solid rgba(0, 0, 0, .15); border-width: 1px 0;        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);}
      .b-example-vr {flex-shrink: 0;width: 1.5rem; height: 100vh; }
      .nav-scroller {position: relative; z-index: 2; height: 2.75rem;overflow-y: hidden;}
      .nav-scroller .nav {display: flex; flex-wrap: nowrap; padding-bottom: 1rem; margin-top: -1px; overflow-x: auto; text-align: center; white-space: nowrap; -webkit-overflow-scrolling: touch;}
      .bi { vertical-align: -.125em; fill: currentColor; color: #80d100;}
      .login_false{display:none;}
      .login_true{display:inline-block;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!--심볼 그대로 둬두 될꺼에요-->
	<svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="40"
		height="40" preserveAspectRatio="xMidYMid meet" style="display: none;">
      <symbol id="bootstrap" viewBox="0 0 500 500">
         <g
			transform="translate(0.000000,500.000000) scale(0.100000,-0.100000)"
			class="bi" fill="#000000" stroke="none">
            <path
			d="M1249 4696 c-207 -85 -370 -217 -462 -377 -38 -65 -36 -71 26 -52 133 39 273 131 363 239 44 53 144 215 132 214 -2 0 -28 -11 -59 -24z" />
            <path
			d="M3711 4678 c98 -195 286 -357 477 -412 62 -18 63 -13 22 58 -74 131 -218 255 -395 342 -60 30 -113 54 -117 54 -5 0 1 -19 13 -42z" />
            <path
			d="M739 4577 c-75 -91 -164 -255 -194 -357 -19 -64 -27 -149 -16 -190 l8 -35 56 58 c69 71 109 151 142 279 21 85 45 279 34 277 -2 0 -16 -15 -30 -32z" />
            <path
			d="M4234 4523 c8 -118 49 -281 89 -357 17 -32 56 -84 86 -115 l54 -56 9 45 c24 129 -69 363 -215 541 l-29 34 6 -92z" />
            <path
			d="M980 4257 c-176 -61 -299 -147 -354 -247 -15 -28 -25 -54 -22 -57 22 -22 175 17 249 64 99 62 284 273 240 273 -10 0 -61 -15 -113 -33z" />
            <path
			d="M3921 4243 c41 -61 160 -180 220 -220 25 -18 73 -41 107 -52 60 -20 152 -28 152 -13 0 20 -63 112 -98 144 -62 56 -176 119 -281 154 -134 46 -140 45 -100 -13z" />
            <path
			d="M418 4143 c-88 -192 -118 -367 -83 -486 24 -81 31 -87 60 -52 66 79 97 188 96 341 -1 94 -21 258 -34 271 -2 2 -20 -32 -39 -74z" />
            <path
			d="M4530 4165 c-18 -79 -27 -245 -18 -321 4 -34 16 -86 26 -117 21 -57 76 -147 92 -147 4 0 17 21 27 48 14 36 18 72 17 152 -1 122 -29 232 -93 365 l-38 80 -13 -60z" />
            <path
			d="M791 3940 c-83 -40 -175 -105 -229 -164 -48 -52 -92 -137 -92 -177 0 -25 2 -26 33 -19 125 29 227 121 306 279 31 61 53 111 48 111 -1 0 -31 -14 -66 -30z" />
            <path
			d="M4150 3946 c20 -53 65 -134 106 -193 68 -96 145 -151 242 -173 30 -7 32 -6 32 19 0 42 -45 127 -96 181 -50 54 -144 120 -231 164 -64 32 -65 32 -53 2z" />
            <path
			d="M197 3679 c-24 -134 -23 -318 3 -400 20 -65 72 -159 89 -159 14 0 40 73 52 147 18 111 -15 268 -90 428 l-37 79 -17 -95z" />
            <path
			d="M4748 3693 c-92 -200 -115 -369 -70 -512 22 -69 24 -72 41 -57 28 26 69 107 86 171 20 80 19 274 -3 390 l-17 90 -37 -82z" />
            <path
			d="M1290 3693 c0 -3 9 -16 20 -28 19 -20 20 -37 22 -328 1 -203 5 -310 12 -316 6 -4 43 -8 81 -7 65 1 70 3 73 24 4 27 15 28 50 2 61 -44 163 -43 244 2 62 35 89 98 94 217 5 90 3 100 -23 151 -39 76 -96 105 -203 104 -50 0 -86 -6 -107 -17 -18 -9 -34 -17 -37 -17 -3 0 -7 48 -8 108 l-3 107 -107 3 c-60 1 -108 -1 -108 -5z m148 -129 c2 -16 10 -50 18 -75 13 -40 13 -50 -2 -90 -12 -34 -15 -73 -12 -169 3 -106 1 -125 -12 -125 -11 0 -17 16 -22 55 -8 71 -10 388 -2 418 9 31 28 22 32 -14z m216 -104 c43 -16 57 -58 58 -183 0 -132 -14 -185 -55 -205 -66 -32 -131 20 -143 114 -10 85 0 195 21 232 26 44 72 60 119 42z m156 -191 c0 -39 -4 -69 -10 -69 -6 0 -10 32 -10 76 0 47 4 73 10 69 6 -3 10 -37 10 -76z" />
            <path
			d="M3300 3691 c0 -5 11 -18 25 -29 23 -18 25 -27 25 -96 l0 -76 -45 0 c-25 0 -45 -3 -45 -8 0 -20 33 -51 58 -54 l27 -3 6 -165 c3 -101 10 -174 17 -187 23 -42 65 -55 191 -56 115 -2 116 -2 119 22 5 31 -12 41 -73 41 -28 0 -56 5 -63 12 -8 8 -12 63 -12 180 l0 168 70 0 c56 0 72 3 77 16 7 19 -5 43 -29 58 -11 6 -26 4 -51 -7 -69 -33 -72 -30 -72 85 l0 103 -112 3 c-68 2 -113 -1 -113 -7z m155 -128 c3 -21 10 -52 15 -69 6 -19 7 -42 1 -60 -5 -16 -12 -85 -16 -154 -3 -68 -8 -126 -11 -129 -15 -15 -24 35 -24 132 0 70 -5 120 -14 141 -12 29 -12 40 -1 73 8 21 14 50 15 64 0 52 27 53 35 2z" />
            <path
			d="M655 3599 c-92 -74 -192 -193 -233 -275 -42 -83 -67 -224 -39 -224 25 0 103 57 149 110 72 82 151 256 182 403 4 15 3 27 -1 27 -5 0 -31 -18 -58 -41z" />
            <path
			d="M4280 3638 c0 -2 11 -46 25 -98 38 -138 107 -271 180 -345 61 -61 128 -105 141 -92 4 4 3 39 -4 79 -14 93 -64 193 -142 285 -71 84 -200 194 -200 171z" />
            <path
			d="M2215 3511 c-53 -14 -113 -50 -135 -81 -72 -102 -57 -285 29 -363 53 -48 100 -61 216 -62 99 0 195 22 195 46 0 5 7 9 15 9 27 0 71 93 56 119 -4 7 -38 11 -88 10 l-80 -1 -12 -54 c-15 -65 -38 -84 -103 -84 -40 0 -50 4 -67 28 -11 16 -22 54 -26 88 l-7 61 122 6 c68 4 157 7 198 7 l75 0 -6 56 c-3 31 -18 81 -32 110 -22 45 -36 59 -78 81 -44 23 -67 27 -147 29 -52 2 -108 -1 -125 -5z m178 -78 c24 -42 35 -138 16 -144 -8 -2 -56 -3 -106 -1 -106 4 -104 1 -82 102 15 70 29 82 97 78 51 -3 58 -6 75 -35z m-246 -139 c16 -31 16 -38 3 -61 -28 -49 -40 -40 -40 31 0 74 12 84 37 30z" />
            <path
			d="M2770 3505 c-131 -41 -138 -175 -12 -220 26 -10 61 -23 77 -30 17 -7 64 -25 105 -40 41 -14 80 -31 87 -37 17 -14 17 -79 0 -102 -18 -25 -92 -39 -133 -26 -39 13 -54 35 -54 78 0 36 -13 42 -90 42 -76 0 -90 -6 -90 -39 0 -31 44 -77 100 -107 30 -16 58 -19 190 -19 137 0 160 2 201 21 40 19 49 28 63 70 15 45 15 50 -2 83 -20 39 -68 71 -135 91 -23 7 -51 16 -62 21 -11 5 -47 17 -79 27 -39 11 -66 26 -79 44 -19 26 -19 27 -1 64 41 82 166 63 176 -26 4 -36 14 -40 101 -40 l77 0 0 29 c0 43 -42 87 -106 110 -44 17 -77 21 -172 20 -70 0 -135 -6 -162 -14z" />
            <path
			d="M84 3190 c20 -206 134 -432 255 -503 l31 -18 0 63 c0 155 -81 318 -231 463 l-61 60 6 -65z" />
            <path
			d="M568 3185 c-67 -84 -130 -198 -153 -279 -17 -58 -18 -206 -2 -223 11 -10 78 49 113 100 61 88 108 277 102 408 l-3 64 -57 -70z" />
            <path
			d="M4370 3184 c0 -132 40 -295 94 -389 33 -56 105 -120 119 -106 5 5 12 43 15 84 5 90 -13 161 -70 267 -34 63 -142 210 -154 210 -2 0 -4 -30 -4 -66z" />
            <path
			d="M4856 3192 c-151 -154 -226 -308 -226 -463 l0 -60 31 18 c49 29 125 115 157 180 53 104 109 306 100 362 -3 21 -8 18 -62 -37z" />
            <path
			d="M611 2846 c-53 -93 -95 -201 -112 -284 -14 -73 -8 -201 13 -251 l14 -34 36 44 c66 82 90 148 109 299 11 93 6 260 -10 287 -5 9 -21 -10 -50 -61z" />
            <path
			d="M4333 2894 c-13 -50 -7 -293 10 -372 18 -79 53 -153 102 -209 l32 -37 18 67 c37 136 6 295 -91 472 -63 116 -61 114 -71 79z" />
            <path
			d="M79 2733 c37 -119 137 -290 214 -365 41 -40 154 -104 165 -94 10 11 -20 120 -51 186 -46 99 -187 235 -334 323 -7 5 -5 -14 6 -50z" />
            <path
			d="M4852 2734 c-95 -65 -223 -196 -257 -263 -29 -58 -57 -154 -53 -181 3 -19 5 -19 63 8 99 48 178 139 260 302 31 62 79 190 71 190 -1 0 -39 -25 -84 -56z" />
            <path
			d="M2270 2705 c0 -8 9 -19 19 -25 25 -13 36 -62 19 -89 -10 -16 -10 -25 -1 -40 7 -12 8 -22 2 -28 -7 -7 -6 -19 2 -35 8 -18 8 -31 1 -45 -7 -12 -7 -25 -1 -34 13 -20 11 -153 -3 -184 -8 -19 -9 -28 0 -37 7 -7 8 -17 2 -28 -5 -10 -7 -40 -3 -68 5 -48 7 -50 42 -56 20 -3 57 -6 84 -6 l47 0 0 344 0 345 -105 0 c-83 0 -105 -3 -105 -14z m138 -335 c0 -102 -3 -194 -8 -205 -5 -12 -8 73 -8 210 0 130 3 219 8 205 4 -14 8 -108 8 -210z" />
            <path
			d="M2575 2710 c-3 -5 5 -16 17 -25 l23 -15 1 -310 c0 -170 3 -313 7 -317 4 -4 42 -7 85 -8 l77 0 3 334 c2 294 0 333 -13 327 -9 -3 -15 0 -15 9 0 11 -19 14 -90 14 -49 0 -92 -4 -95 -9z m135 -335 c0 -143 -4 -225 -10 -225 -6 0 -10 76 -10 209 0 188 4 241 16 241 2 0 4 -101 4 -225z" />
            <path
			d="M707 2498 c-34 -92 -67 -237 -67 -303 0 -92 63 -272 93 -262 7 2 28 34 47 72 32 62 35 77 38 167 2 54 -1 129 -8 166 -12 75 -59 232 -69 232 -4 0 -19 -33 -34 -72z" />
            <path
			d="M4227 2488 c-37 -118 -49 -203 -45 -316 3 -90 6 -105 38 -167 19 -38 40 -70 47 -72 29 -10 93 172 93 263 -1 90 -77 374 -101 374 -4 0 -18 -37 -32 -82z" />
            <path
			d="M1120 2525 c-97 -30 -133 -114 -75 -175 15 -16 49 -37 74 -47 25 -9 57 -23 71 -30 14 -7 31 -13 38 -13 7 0 20 -4 30 -9 9 -6 39 -18 65 -27 59 -21 80 -48 71 -93 -9 -42 -44 -64 -104 -65 -58 -1 -87 21 -96 73 -4 20 -12 39 -18 43 -18 13 -141 9 -154 -4 -20 -20 -14 -45 18 -82 51 -57 103 -71 270 -71 135 0 149 2 195 25 42 21 52 32 65 68 14 40 13 46 -5 80 -22 40 -95 87 -155 98 -19 4 -39 10 -45 14 -5 4 -37 15 -70 25 -93 26 -115 55 -86 115 18 38 56 53 108 44 40 -8 63 -33 66 -73 2 -39 16 -43 112 -39 l70 3 -2 30 c-3 40 -68 99 -127 114 -62 15 -261 13 -316 -4z" />
            <path
			d="M1817 2530 c-117 -30 -182 -110 -179 -220 5 -139 13 -164 72 -221 51 -50 96 -63 221 -63 98 -1 109 1 164 29 66 34 108 84 103 125 -3 24 -5 25 -90 27 l-87 2 -7 -45 c-10 -68 -35 -94 -93 -94 -63 0 -88 26 -103 108 -6 34 -10 64 -7 66 2 3 91 8 198 12 l194 7 -6 57 c-7 85 -43 148 -103 184 -44 26 -59 30 -144 32 -52 2 -112 -1 -133 -6z m172 -61 c12 -13 23 -43 26 -74 12 -91 14 -89 -100 -86 -55 1 -102 5 -104 7 -8 8 18 127 34 150 13 20 24 24 70 24 42 0 59 -5 74 -21z m-241 -144 c16 -35 15 -67 -2 -91 -19 -25 -27 -15 -33 40 -9 72 12 101 35 51z m52 -174 c0 -5 -7 -12 -16 -15 -22 -9 -24 -8 -24 9 0 8 9 15 20 15 11 0 20 -4 20 -9z" />
            <path
			d="M3075 2531 c-53 -14 -113 -50 -135 -81 -72 -102 -57 -285 29 -363 53 -48 100 -61 216 -62 99 0 195 22 195 46 0 5 7 9 15 9 27 0 71 93 56 119 -4 7 -38 11 -88 10 l-80 -1 -12 -54 c-15 -65 -38 -84 -103 -84 -40 0 -50 4 -67 28 -11 16 -22 54 -26 88 l-7 61 122 6 c68 4 157 7 198 7 l75 0 -6 56 c-3 31 -18 81 -32 110 -22 45 -36 59 -78 81 -44 23 -67 27 -147 29 -52 2 -108 -1 -125 -5z m178 -78 c24 -42 35 -138 16 -144 -8 -2 -56 -3 -106 -1 -106 4 -104 1 -82 102 15 70 29 82 97 78 51 -3 58 -6 75 -35z m-246 -139 c16 -31 16 -38 3 -61 -28 -49 -40 -40 -40 31 0 74 12 84 37 30z" />
            <path
			d="M3520 2529 c0 -7 11 -22 25 -35 l25 -23 -3 -209 c-1 -116 2 -214 6 -219 5 -4 43 -8 85 -8 l77 0 5 195 5 195 45 23 c29 15 55 21 73 18 15 -3 50 0 78 6 42 10 49 15 47 32 -3 19 -11 21 -76 24 -66 3 -107 -3 -154 -23 -13 -5 -18 -2 -18 8 0 22 -22 27 -126 27 -63 0 -94 -4 -94 -11z m152 -191 c-3 -138 -10 -200 -23 -193 -10 7 -12 246 -3 283 4 12 11 22 18 22 8 0 10 -34 8 -112z" />
            <path
			d="M202 2223 c80 -118 217 -249 305 -290 77 -37 153 -54 153 -34 0 19 -50 113 -82 154 -63 79 -220 179 -356 225 -34 12 -65 22 -68 22 -3 0 19 -35 48 -77z" />
            <path
			d="M4780 2280 c-156 -57 -323 -169 -381 -256 -39 -58 -71 -125 -64 -132 9 -9 106 14 157 37 65 31 152 104 230 194 66 77 135 177 120 177 -4 -1 -32 -10 -62 -20z" />
            <path
			d="M871 2184 c-19 -65 -25 -261 -11 -342 12 -75 59 -182 104 -237 l24 -30 21 69 c25 80 27 148 7 243 -19 89 -69 225 -105 287 l-29 49 -11 -39z" />
            <path
			d="M4083 2163 c-64 -120 -113 -294 -113 -398 0 -29 9 -83 21 -120 l20 -67 25 29 c42 49 91 156 103 224 15 87 13 228 -3 312 -7 37 -15 70 -18 72 -3 3 -19 -21 -35 -52z" />
            <path
			d="M1080 1945 c0 -73 32 -230 62 -305 12 -30 35 -75 52 -100 38 -56 113 -130 132 -130 20 0 19 140 -2 211 -27 91 -117 242 -204 339 l-40 45 0 -60z" />
            <path
			d="M3857 1933 c-78 -96 -153 -224 -177 -302 -25 -78 -28 -221 -6 -221 8 0 45 33 83 74 52 56 76 90 96 142 36 93 69 254 65 323 l-3 56 -58 -72z" />
            <path
			d="M427 1801 c109 -104 234 -188 333 -221 55 -19 190 -29 190 -14 0 3 -8 19 -17 35 -16 27 -18 27 -35 12 -17 -15 -18 -15 -18 5 0 12 6 22 13 22 26 1 -91 95 -158 126 -87 41 -219 79 -305 88 l-65 6 62 -59z" />
            <path
			d="M4545 1853 c-228 -50 -329 -95 -419 -185 -34 -35 -68 -73 -75 -85 -12 -23 -11 -23 59 -23 82 0 164 24 243 72 79 48 187 131 237 182 l44 46 -34 -1 c-19 -1 -44 -3 -55 -6z" />
            <path
			d="M1350 1696 c0 -24 51 -177 72 -220 52 -101 144 -191 226 -220 50 -18 56 -9 42 64 -21 111 -115 238 -247 333 -44 31 -83 57 -87 57 -3 0 -6 -7 -6 -14z" />
            <path
			d="M3550 1646 c-130 -97 -220 -218 -240 -327 -15 -79 -6 -85 70 -47 83 41 137 98 188 195 56 109 98 243 76 243 -5 0 -47 -29 -94 -64z" />
            <path
			d="M686 1466 l-69 -11 89 -47 c107 -56 231 -96 340 -110 66 -8 91 -7 144 6 36 9 69 21 74 26 10 10 -57 61 -129 97 -91 47 -295 65 -449 39z" />
            <path
			d="M3993 1465 c-83 -13 -147 -40 -232 -98 l-44 -30 24 -12 c51 -27 141 -37 223 -26 122 17 317 89 390 144 18 13 12 15 -58 26 -96 14 -197 13 -303 -4z" />
            <path
			d="M1310 1210 c-41 -11 -113 -39 -159 -62 -94 -47 -95 -46 33 -72 99 -21 247 -21 317 0 56 17 129 55 148 78 16 19 -20 40 -97 60 -78 21 -150 19 -242 -4z" />
            <path
			d="M3462 1221 c-65 -17 -123 -43 -119 -55 6 -21 99 -76 155 -92 71 -21 267 -15 365 11 l69 18 -49 28 c-120 69 -328 114 -421 90z" />
            <path
			d="M915 999 c-84 -65 -76 -63 -149 -27 -85 42 -95 34 -75 -54 8 -35 13 -72 11 -83 -1 -11 -23 -40 -47 -65 -25 -25 -45 -51 -45 -58 0 -15 29 -21 115 -24 l70 -3 35 -65 c19 -36 42 -65 50 -65 15 0 28 34 46 120 8 38 12 40 54 48 116 21 129 31 84 69 -15 13 -43 37 -61 53 l-33 30 10 64 c17 100 3 112 -65 60z" />
            <path
			d="M4045 1008 c-3 -7 -6 -46 -7 -87 l-3 -75 -54 -31 c-89 -52 -88 -69 7 -100 61 -20 78 -40 92 -115 15 -77 25 -83 66 -35 18 22 39 52 45 68 13 32 11 31 113 32 53 0 80 4 83 12 3 7 -18 37 -46 66 -28 30 -51 61 -51 69 0 9 11 40 25 70 14 29 25 59 25 66 0 18 -38 15 -104 -8 l-57 -19 -54 49 c-57 52 -72 59 -80 38z" />
            <path
			d="M1688 718 c-13 -13 -37 -41 -54 -62 -31 -40 -32 -40 -71 -28 -49 15 -110 16 -118 2 -4 -6 7 -35 24 -65 39 -69 39 -96 0 -157 -30 -47 -33 -78 -6 -78 7 0 39 7 70 15 32 8 66 15 75 15 9 0 42 -25 73 -56 32 -31 62 -53 68 -50 7 4 11 41 11 92 l0 85 48 19 c102 43 104 59 12 104 l-65 31 -10 74 c-6 42 -15 76 -22 78 -7 3 -23 -6 -35 -19z" />
            <path
			d="M3291 722 c-5 -9 -15 -46 -21 -80 -14 -69 -17 -72 -96 -92 -23 -5 -48 -18 -55 -27 -12 -14 -10 -19 20 -42 98 -75 96 -73 96 -153 0 -92 11 -96 87 -28 31 27 64 50 75 50 10 0 42 -9 71 -20 29 -11 59 -20 67 -20 25 0 17 35 -22 100 l-36 61 22 27 c49 61 72 102 66 112 -5 8 -31 10 -85 5 l-78 -7 -37 60 c-41 66 -60 80 -74 54z" />
            <path
			d="M2503 628 c-6 -7 -23 -38 -38 -68 -15 -30 -29 -57 -32 -60 -2 -2 -33 -5 -69 -5 -43 -1 -70 -6 -79 -16 -13 -13 -10 -21 30 -68 50 -59 56 -88 30 -161 -8 -23 -15 -46 -15 -50 0 -22 37 -16 96 15 37 19 72 35 77 35 6 0 37 -18 69 -41 84 -58 106 -42 73 51 -25 71 -21 85 41 130 74 56 70 71 -26 90 l-75 15 -25 69 c-26 71 -39 86 -57 64z" />
         </g>
      </symbol>
   </svg>

	<nav class="py-2 bg-light border-bottom">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<!--여기 뭐 넣을지 생각....-->
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Features</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Pricing</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">About</a></li>
			</ul>
			<ul class="nav">
				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_true "><a href="">
						<!--마이페이지 이동--> <!--로그인 자기 이미지 띄우기--> <img
						src="https://github.com/mdo.png" alt="mdo" width="40" height="40"
						class="rounded-circle">
				</a></li>
				<li class="nav-item login_true "><a href="#"
					class="nav-link link-dark px-2">Logout</a></li>
				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_false">
					<!--로그인 페이지 이동--> <a href="#" class="nav-link link-dark px-2">Login</a>
				</li>

				<li class="nav-item login_false">
					<!--회원가입 페이지 이동--> <a href="#" class="nav-link link-dark px-2">Sign
						up</a>
				</li>
			</ul>
		</div>
	</nav>
	<header class="py-3 mb-4 border-bottom">
		<div class="container d-flex flex-wrap justify-content-center">
			<a href="/"
				class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
				<svg class="bi me-2" width="40" height="40">
               <use xlink:href="#bootstrap" />
            </svg> <!--타이틀--> <span class="fs-4">Best Seller</span>
			</a>
			<form class="col-12 col-lg-auto mb-3 mb-lg-0" role="search">
				<input type="search" class="form-control" placeholder="제품 검색"
					aria-label="Search">
			</form>
		</div>
	</header>


	<main>
	<a class="newatcl" href="${contextPath}/board/addArticleForm.do">+</a>
		<!--메인 컨테이너-->
		  <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>

        <div class="container">
          <div class="carousel-caption text-start">
            <h1>Example headline.</h1>
            <p>Some representative placeholder content for the first slide of the carousel.</p>
            <p><a class="btn btn-lg btn-primary" href="#">Sign up today</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>

        <div class="container">
          <div class="carousel-caption">
            <h1>Another example headline.</h1>
            <p>Some representative placeholder content for the second slide of the carousel.</p>
            <p><a class="btn btn-lg btn-primary" href="#">Learn more</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>

        <div class="container">
          <div class="carousel-caption text-end">
            <h1>One more for good measure.</h1>
            <p>Some representative placeholder content for the third slide of this carousel.</p>
            <p><a class="btn btn-lg btn-primary" href="#">Browse gallery</a></p>
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>

		<!--등록 제품 사진-->

		<div class="album py-5 bg-light">
			<div class="container">

				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:choose>
						<c:when test="${!empty articlesList }">
							<c:forEach var="articles" items="${articlesList }">
								<div class="col">
									<a
								href="${contextPath}/board/readArticle.do?num_aticle=${articles.num_aticle}">
										<div class="card shadow-sm">
										<span style="width: 150px; display: none;">${articles.num_aticle}</span>
											<svg class="bd-placeholder-img card-img-top" width="100%"
												height="225" xmlns="http://www.w3.org/2000/svg" role="img"
												aria-label="Placeholder: Thumbnail"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#55595c" />
												<text x="50%" y="50%" fill="#eceeef" dy=".3em">예약일때 표기ex ${articles.deal_status}</text>
											</svg>

											<div class="card-body">

												<p class="card-text">${articles.title}</p>
												<p class="card-text">${articles.contents}</p>
												<div
													class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<button type="button"
															class="btn btn-sm btn-outline-secondary">View</button>
														<button type="button"
															class="btn btn-sm btn-outline-secondary">Edit</button>
													</div>
													<small class="text-muted">${articles.upload}</small>
												
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</c:when>

						<c:when test="${empty articlesList }">
							<p>리스트가 없다능</p>
							<c:redirect url="/board/listArticles.do"></c:redirect>
							<%-- 
		<a href="${contextPath}/board/addArticleForm.do">글쓰기</a>
		
		--%>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>


		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br> <br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<div style="border: 1px solid #000000;">
			<c:choose>

				<c:when test="${!empty articlesList }">
					<ol>
						<li style="list-style: none;" value="0"><span
							style="width: 150px; display: inline-block;">닉넴</span> <span
							style="width: 200px; display: inline-block;">제목</span> <span
							style="width: 200px; display: inline-block;">상태</span> <span
							style="width: 200px; display: inline-block;">날짜</span></li>
						<c:forEach var="articles" items="${articlesList }">

							<li><a
								href="${contextPath}/board/readArticle.do?num_aticle=${articles.num_aticle}">
									<span style="width: 150px; display: none;">${articles.num_aticle}</span>
									<span style="width: 150px; display: inline-block;">${articles.nickname}</span>
									<span style="width: 200px; display: inline-block;">${articles.title}</span>
									<span style="width: 200px; display: inline-block;">${articles.deal_status}</span>
									<span style="width: 200px; display: inline-block;">${articles.upload}</span>
							</a></li>

						</c:forEach>
					</ol>
				</c:when>
				<c:when test="${empty articlesList }">
					<p>리스트가 없다능</p>
					<c:redirect url="/board/listArticles.do"></c:redirect>
					<%-- 
		<a href="${contextPath}/board/addArticleForm.do">글쓰기</a>
		
		--%>
				</c:when>
			</c:choose>
		</div>
		
		
		<!--부트스트랩 적용-->
<script src="/docs/5.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>