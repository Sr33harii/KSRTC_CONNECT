"""
URL configuration for KSRTC_Connect project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path

from myapp import views

urlpatterns = [

    path('adminhome/',views.adminhome),

    path('login_get/',views.login_get),
    path('login_post/',views.login_post),

    path('admin_change_password/',views.admin_change_password),
    path('admin_change_passward_post/',views.admin_change_passward_post),

    path('admin_forget_password/',views.admin_forget_password),
    # path('admin_forget_passward_post/',views.admin_forget_passward_post),

    path('admin_view_busdriver_and_verify/',views.admin_view_busdriver_and_verify),

    path('admin_add_route/',views.admin_add_route),
    path('admin_add_route_post/',views.admin_add_route_post),

    path('admin_view_route/',views.admin_view_route),

    path('admin_edit_route/<id>',views.admin_edit_route),
    path('admin_edit_route_post/',views.admin_edit_route_post),
    path('admin_delete_route_post/<id>',views.admin_delete_route_post),

    path('admin_add_stop/',views.admin_add_stop),
    path('admin_add_stop_post/',views.admin_add_stop_post),

    path('admin_view_stop/',views.admin_view_stop),

    path('admin_edit_stop/<id>',views.admin_edit_stop),
    path('admin_edit_stop_post/',views.admin_edit_stop_post),

    path('admin_delete_stop/<id>',views.admin_delete_stop),

    path('admin_view_bus/',views.admin_view_bus),

    path('admin_view_seat/',views.admin_view_seat),
    path('add_fair_get/',views.add_fair_get),
    path('add_fair_post/',views.add_fair_post),
    path('admin_edit_fair/<id>',views.admin_edit_fair),
    path('admin_delete_fair/<id>',views.admin_delete_fair),

    path('admin_view_fair/',views.admin_view_fair),
    path('edit_fair_post/',views.edit_fair_post),

    path('admin_view_booking/',views.admin_view_booking),

    path('admin_view_complaint/',views.admin_view_complaint),

    path('admin_Sent_Repaly/',views.admin_Sent_Repaly),
    path('sent_replay_post/',views.sent_replay_post),

    path('admin_view_feedback/',views.admin_view_feedback),
    path('admin_logout/',views.admin_logout),



    path('driver_signip/',views.driver_signip),
    path('mobile_login/',views.mobile_login),
    path('driver_view_profile/',views.driver_view_profile),
    path('driver_edit_profile/',views.driver_edit_profile),
    path('driver_change_password/',views.driver_change_password),
    path('add_bus/',views.add_bus),
    path('driver_view_bus/',views.driver_view_bus),
    path('driver_delete_bus/',views.driver_delete_bus),
    path('driver_get_bus_root/',views.driver_get_bus_root),
    path('driver_edit_bus_get/',views.driver_edit_bus_get),
    path('driver_edit_bus_post/',views.driver_edit_bus_post),
    path('driver_add_seat/',views.driver_add_seat),
    path('driver_view_seat/',views.driver_view_seat),
    path('driver_edit_seat/',views.driver_edit_seat),
    path('driver_location_update/',views.driver_location_update),


    # user----------------------
    path('user_signip/',views.user_signip),
    path('user_view_profile/',views.user_view_profile),
    path('user_edit_profile/',views.user_edit_profile),
    path('user_change_password/',views.user_change_password),
    path('user_view_bus/',views.user_view_bus),
    path('user_view_seat/',views.user_view_seat),
    path('user_sent_complaint/',views.user_sent_complaint),
    path('user_view_complaint/',views.user_view_complaint),
    path('user_sent_feedback/',views.user_sent_feedback),
    path('user_view_feedback/',views.user_view_feedback),
    path('user_book_seat/',views.user_book_seat),
    path('get_stops/', views.get_stops),
    path('search_buses/', views.search_buses),
    path('user_view_seat/', views.user_view_seat),
    path('user_book_seat/', views.user_book_seat),
    path('user_view_booking/', views.user_view_boooking),
    path('makepayment/', views.makepayment),
    path('user_seat_payment/', views.user_seat_payment),
    path('user_view_seat_boooking/', views.user_view_seat_boooking),
    path('forgot_password/', views.forgot_password),
    path('forgotpassword_post/', views.forgotpassword_post),
    path('android_forget_password_post/', views.android_forget_password_post),
    path('driver_edit_seat_get/',views.driver_edit_seat_get)

    ]







