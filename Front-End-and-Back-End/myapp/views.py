import json
import smtplib
from datetime import datetime
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import check_password, make_password
from django.core.files.storage import FileSystemStorage
from django.http import JsonResponse
from django.shortcuts import render, redirect

from django.contrib.auth.models import User, Group

# Create your views here.
from myapp.models import *

# user = User.objects.get(username='user@gmail.com')
# user.set_password('12345')
# user.save()

def login_get(request):
    return render(request,'LOGIN.html')
def login_post(request):
    username=request.POST['username']
    password=request.POST['password']

    if not username or not password:
        messages.warning(request,'must be required')
        return redirect('/myapp/login_get/')
    check=authenticate(request,username=username,password=password)
    if check is not None:
        login(request,check)
        if check.groups.filter(name='admin').exists():
            return redirect('/myapp/adminhome/')
        else:
            messages.warning(request,"Invalid username or password ")
            return redirect('/myapp/login_get/')

    else:
        messages.warning(request, "Invalid username or password ")
        return redirect('/myapp/login_get/')

@login_required(login_url='/myapp/login_get/')
def adminhome(request):
    return render(request, 'adminhome.html')

@login_required(login_url='/myapp/login_get/')
def admin_change_password(request):
    return render(request,'change_password.html')
@login_required(login_url='/myapp/login_get/')
def admin_change_passward_post(request):
    cpassword=request.POST['cpassword']
    newpassword=request.POST['newpassword']
    confirmpassword=request.POST['confirmpassword']
    user = request.user
    if check_password(cpassword, user.password):
        if newpassword == confirmpassword:
            user.set_password(newpassword)
            user.save()
            logout(request)
            return redirect('/myapp/login_get/')
        else:
            return redirect('/myapp/admin_change_password/')
    else:
        return redirect('/myapp/admin_change_password/')


def admin_forget_password(request):
    return render(request,'forget_password.html')
# def admin_forget_passward_post(request):




@login_required(login_url='/myapp/login_get/')
def admin_view_busdriver_and_verify(request):
    data=Driver.objects.all()
    return render(request, 'view_registred_driver.html',{'data':data})



def admin_approve_driver(request,id):
    data=Driver.objects.all()
    return render(request, 'view_registred_driver.html',{'data':data})


@login_required(login_url='/myapp/login_get/')
def admin_add_route(request):
    return render(request, 'add_route.html')

@login_required(login_url='/myapp/login_get/')
def admin_add_route_post(request):
    strating=request.POST['strating']
    destination=request.POST['destination']
    a=Route()
    a.strating=strating
    a.destination=destination
    a.save()
    return redirect('/myapp/admin_view_route/')

@login_required(login_url='/myapp/login_get/')
def admin_view_route(request):
    data=Route.objects.all()
    return render(request, 'view_route.html',{'data':data})

@login_required(login_url='/myapp/login_get/')
def admin_edit_route(request,id):
    a=Route.objects.get(id=id)
    return render(request, 'edit_route.html',{'data':a})

@login_required(login_url='/myapp/login_get/')
def admin_edit_route_post(request):
    id=request.POST['id']
    strating=request.POST['strating']
    destination=request.POST['destination']

    a=Route.objects.get(id=id)
    a.strating = strating
    a.destination = destination
    a.save()

    return redirect('/myapp/admin_view_route/')

@login_required(login_url='/myapp/login_get/')
def admin_delete_route_post(request,id):
    Route.objects.get(id=id).delete()
    return redirect('/myapp/admin_view_route/#start')


@login_required(login_url='/myapp/login_get/')
def admin_add_stop(request):
    r = Route.objects.all()
    return render(request, 'add_stop.html',{'r':r})

@login_required(login_url='/myapp/login_get/')
def admin_add_stop_post(request):
    route=request.POST['route']
    stop = request.POST['stop']
    obj= Stop()
    obj.stop=stop
    obj.ROUTE_id = route
    obj.save()
    return redirect('/myapp/admin_add_stop/#start')

@login_required(login_url='/myapp/login_get/')
def admin_edit_stop(request,id):
    r = Route.objects.all()
    data = Stop.objects.get(id=id)
    return render(request, 'edit_stop.html',{'r':r,'data':data})


@login_required(login_url='/myapp/login_get/')
def admin_edit_stop_post(request):
    destination=request.POST['destination']
    id=request.POST['id']
    route=request.POST['route']
    obj = Stop.objects.get(id=id)
    obj.ROUTE_id=route
    obj.stop= destination
    obj.save()
    return redirect('/myapp/admin_view_stop/')

def admin_delete_stop(request,id):
    Stop.objects.filter(id=id).delete()
    return redirect('/myapp/admin_view_stop/')

@login_required(login_url='/myapp/login_get/')
def add_fair_get(request):
    r = Stop.objects.all()
    return  render(request, 'addfair.html',{'r':r})

@login_required(login_url='/myapp/login_get/')
def add_fair_post(request):
    amount=request.POST['amount']
    fromstop=request.POST['fromstop']
    tostop=request.POST['tostop']
    a=TicketPrize()
    a.FROMSTOP=Stop.objects.get(id=fromstop)
    a.TOSTOP=Stop.objects.get(id=tostop)
    a.amount=amount
    a.save()
    return redirect('/myapp/admin_view_fair/')

@login_required(login_url='/myapp/login_get/')
def admin_view_fair(request):
    data=TicketPrize.objects.all()
    return render(request, 'view fair.html',{'data':data})

@login_required(login_url='/myapp/login_get/')
def admin_edit_fair(request,id):
    r = Stop.objects.all()
    data = TicketPrize.objects.get(id=id)
    return render(request, 'edit_fair.html',{'r':r,'data':data})

@login_required(login_url='/myapp/login_get/')
def edit_fair_post(request):
    id=request.POST['id']
    amount=request.POST['amount']
    fromstop=request.POST['fromstop']
    tostop=request.POST['tostop']
    a=TicketPrize.objects.get(id=id)
    a.FROMSTOP=Stop.objects.get(id=fromstop)
    a.TOSTOP=Stop.objects.get(id=tostop)
    a.amount=amount
    a.save()
    return redirect('/myapp/admin_view_fair/')

@login_required(login_url='/myapp/login_get/')
def admin_delete_fair(request,id):
    TicketPrize.objects.get(id=id).delete()
    return redirect('/myapp/admin_view_fair/')




@login_required(login_url='/myapp/login_get/')
def admin_view_stop(request):
    data=Stop.objects.all()
    return render(request, 'view_stop.html',{'data':data})

@login_required(login_url='/myapp/login_get/')
def admin_view_bus(request):
    data=Bus.objects.all()
    return render(request, 'view_bus.html',{'data':data})

@login_required(login_url='/myapp/login_get/')
def admin_view_seat(request):
    data=Seat.objects.all()
    return render(request, 'view_seat.html',{'data':data})\

@login_required(login_url='/myapp/login_get/')
def admin_view_booking(request):
    data=Booking.objects.all()
    return render(request, 'view_booking.html',{'data':data})

@login_required(login_url='/myapp/login_get/')
def admin_view_complaint(request):
    data=Complaints.objects.all()
    return render(request, 'view_complaint.html',{'data':data})\


@login_required(login_url='/myapp/login_get/')
def admin_Sent_Repaly(request):
    return render(request, 'Sent_Replay.html')

@login_required(login_url='/myapp/login_get/')
def sent_replay_post(request):
    destination=request.POST['destination']
    return



@login_required(login_url='/myapp/login_get/')
def admin_view_feedback(request):
    data=Feedback.objects.all()
    return render(request, 'view_feedback.html',{'data':data})


def admin_logout(request):
    logout(request)
    return redirect('/myapp/login_get/')


# driver


def driver_signip(request):
    licenceno=request.POST['licenceno']
    name=request.POST['name']
    phone=request.POST['phone']
    place= request.POST['place']
    pin= request.POST['pin']
    post= request.POST['post']
    genter= request.POST['gender']
    dob= request.POST['dob']
    district = request.POST['district']
    state= request.POST['state']
    password= request.POST['password']
    email= request.POST['email']
    photo= request.FILES['photo']


    fs=FileSystemStorage()
    date=datetime.now().strftime('%Y%m%d%H%M%S')+'.jpg'
    fs.save(date,photo)
    path=fs.url(date)

    a=User.objects.create_user(username=email,password=password)
    a.groups.add(Group.objects.get(name='Driver'))

    obj=Driver()
    obj.licenceno=licenceno
    obj.name=name
    obj.email=email
    obj.phone=phone
    obj.place=place
    obj.pin=pin
    obj.post=post
    obj.genter=genter
    obj.dob=dob
    obj.district=district
    obj.state=state
    obj.photo=path
    obj.USER=a
    obj.save()
    return JsonResponse({'status':'ok'})

def mobile_login(request):
    username=request.POST['username']
    password= request.POST['password']
    check = authenticate(request, username=username, password=password)
    if check is not None:
        login(request,check)
        if check.groups.filter(name='Driver').exists():
            return JsonResponse({'status':'ok','lid':str(check.id) ,'type':'driver'})
        elif check.groups.filter(name='user').exists():
            return JsonResponse({'status':'ok','lid':str(check.id) ,'type':'user'})
        else:
            return JsonResponse({'status':'no'})

    else:
        return JsonResponse({'status':'no'})

def driver_view_profile(request):
    id=request.POST['lid']
    a=Driver.objects.get(USER_id=id)
    return JsonResponse({
        'status':'ok',
        'licenceno':a.licenceno,
        'name':a.name,
        'email':a.email,
        'phone':a.phone,
        'place':a.place,
        'pin':a.pin,
        'post':a.post,
        'gender':a.genter,
        'dob':a.dob,
        'district':a.district,
        'state':a.state,
        'photo':a.photo,
    })
def driver_edit_profile(request):
    id=request.POST['lid']
    licenceno = request.POST['licenceno']
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    place = request.POST['place']
    pin = request.POST['pin']
    post = request.POST['post']
    genter = request.POST['gender']
    dob = request.POST['dob']
    district = request.POST['district']
    state = request.POST['state']

    obj=Driver.objects.get(USER_id=id)
    if 'photo' in request.FILES:
        photo = request.FILES['photo']
        fs = FileSystemStorage()
        date = datetime.now().strftime('%Y%m%d%H%M%S') + '.jpg'
        fs.save(date, photo)
        path = fs.url(date)
        obj.photo=path
        obj.save()
    obj.licenceno = licenceno
    obj.name = name
    obj.email = email
    obj.phone = phone
    obj.place = place
    obj.pin = pin
    obj.post = post
    obj.genter = genter
    obj.dob = dob
    obj.district = district
    obj.state = state
    obj.save()
    return JsonResponse({'status': 'ok'})



def driver_change_password(request):
    id=request.POST['lid']
    currentpassword = request.POST['currentpassword']
    newpassword = request.POST['newpassword']
    confirmpassword = request.POST['confirmpassword']
    user=User.objects.get(id=id)
    if user.check_password(currentpassword):
        if newpassword == confirmpassword:
            user.set_password(newpassword)
            user.save()
            logout(request)
            return JsonResponse({'status': 'ok'})
        else:
            return JsonResponse({'status': 'no'})
    else:
        return JsonResponse({'status': 'no'})


def add_bus(request):
    id=request.POST['lid']
    busname=request.POST['busname']
    reg_no=request.POST['reg_no']
    fromroute=request.POST['fromroute']
    toroute=request.POST['toroute']
    description=request.POST['description']

    obj=Bus()
    obj.busname=busname
    obj.reg_no=reg_no
    obj.FromROUTE=Route.objects.get(id=fromroute)
    obj.To_ROUTE=Route.objects.get(id=toroute)
    obj.description=description
    obj.DRIVER= Driver.objects.get(USER_id=id)
    obj.save()
    return JsonResponse({'status': 'ok'})


def driver_view_bus(request):
    id=request.POST['lid']
    l = []
    a=Bus.objects.filter(DRIVER__USER_id=id)
    pass#(a,"Bus")

    for i in a:
        l.append({
            'id':i.id,
            'busname':i.busname,
            'reg_no':i.reg_no,
            'FromROUTE':i.FromROUTE.strating,
            'To_ROUTE':i.To_ROUTE.destination,
            'description':i.description,
        })
        pass#(l,"bus")
    return JsonResponse({'status':'ok','data':l})


def driver_delete_bus(request):
    id=request.POST['bid']
    Bus.objects.get(id=id).delete()
    return JsonResponse({'status': 'ok'})

def driver_get_bus_root(request):
    a = Route.objects.all()
    l = []
    for i in a:
        l.append({
            'id': i.id,
            'starting': i.strating,
            'destination': i.destination,
        })
    return JsonResponse({'status': 'ok', 'data': l})

def driver_edit_bus_get(request):
    bid=request.POST['bid']
    b=Bus.objects.get(id=bid)
    return JsonResponse({
        'status':'ok',
        'busname':b.busname,
        'reg_no':b.reg_no,
        'fromroute':b.FromROUTE.id,
        'toroute':b.To_ROUTE.id,
        'description':b.description,
    })


def driver_edit_bus_post(request):
    id = request.POST['bid']
    busname = request.POST['busname']
    reg_no = request.POST['reg_no']
    fromroute = request.POST['fromroute']
    toroute = request.POST['toroute']
    description = request.POST['description']

    obj = Bus.objects.get(id=id)
    obj.busname = busname
    obj.reg_no = reg_no
    obj.FromROUTE_id = fromroute
    obj.To_ROUTE_id = toroute
    obj.description = description
    obj.save()
    return JsonResponse({'status': 'ok'})

def driver_add_seat(request):
    seat_no=request.POST['seat_no']
    seat_type=request.POST['seat_type']
    id=request.POST['bid']
    pass#(seat_no,seat_type,id,'gfsgfdnh')

    obj=Seat()
    obj.seat_no=seat_no
    obj.seat_type=seat_type
    obj.BUS=Bus.objects.get(id=id)
    obj.save()
    return JsonResponse({'status': 'ok'})

# def driver_add_fair(request):
#     amount=request.POST['amount']
#     id=request.POST['bid']
#
#     obj=Fair()
#     obj.amount=amount
#     obj.BUS=Bus.objects.get(id=id)
#     obj.save()
#     return JsonResponse({'status': 'ok'})

def driver_view_seat(request):
    id=request.POST['bid']
    a=Seat.objects.filter(BUS=id)
    l=[]
    for i in a:
        l.append({
            'id':i.id,
            'seatno': i.seat_no,
            'seattype': i.seat_type

        })
    pass#(l,'jhvhj')
    return JsonResponse({
        'status':'ok',
        'data':l

    })

def driver_edit_seat(request):
    seat_no = request.POST['seat_no']
    seat_type = request.POST['seat_type']
    id = request.POST['seid']

    obj = Seat.objects.get(id=id)
    obj.seat_no = seat_no
    obj.seat_type = seat_type
    obj.save()
    return JsonResponse({'status': 'ok'})

def driver_edit_seat_get(request):
    id=request.POST['seid']
    b=Seat.objects.get(id=id)
    return JsonResponse({
        'status':'ok',
        'seat_no':b.seat_no,
        'seat_type':b.seat_type,})

def driver_location_update(request):
    lid=request.POST['lid']
    latitude=request.POST['latitude']
    longitude=request.POST['longitude']

    if Loacation.objects.filter(DRIVER__USER=lid):
        obj1=Loacation.objects.get(DRIVER__USER=lid)
        obj1.latitude=latitude
        obj1.longitude=longitude
        obj1.save()
        return JsonResponse({'status':'ok'})

    else:

        obj=Loacation()
        obj.latitude=latitude
        obj.longitude=longitude
        obj.DRIVER=Driver.objects.get(USER_id=lid)
        obj.save()
        return JsonResponse({'status':'ok'})
# U S E R -----------------------------------------

def user_signip(request):
    name=request.POST['name']
    phone=request.POST['phone']
    place= request.POST['place']
    pin= request.POST['pin']
    post= request.POST['post']
    genter= request.POST['gender']
    dob= request.POST['dob']
    district = request.POST['district']
    state= request.POST['state']
    password= request.POST['password']
    email= request.POST['email']
    photo= request.FILES['photo']


    fs=FileSystemStorage()
    date=datetime.now().strftime('%Y%m%d%H%M%S')+'.jpg'
    fs.save(date,photo)
    path=fs.url(date)

    a=User.objects.create_user(username=email,password=password)
    a.groups.add(Group.objects.get(name='user'))

    obj=Users()
    obj.name=name
    obj.email=email
    obj.phone=phone
    obj.place=place
    obj.pin=pin
    obj.post=post
    obj.genter=genter
    obj.dob=dob
    obj.district=district
    obj.state=state
    obj.photo=path
    obj.USER=a
    obj.save()
    return JsonResponse({'status':'ok'})

def user_view_profile(request):
    id=request.POST['lid']
    a=Users.objects.get(USER_id=id)
    return JsonResponse({
        'status':'ok',
        'name':a.name,
        'email':a.email,
        'phone':a.phone,
        'place':a.place,
        'pin':a.pin,
        'post':a.post,
        'gender':a.genter,
        'dob':a.dob,
        'district':a.district,
        'state':a.state,
        'photo':a.photo,
    })

def user_edit_profile(request):
    id=request.POST['lid']
    name = request.POST['name']
    email = request.POST['email']
    phone = request.POST['phone']
    place = request.POST['place']
    pin = request.POST['pin']
    post = request.POST['post']
    genter = request.POST['gender']
    dob = request.POST['dob']
    district = request.POST['district']
    state = request.POST['state']

    obj=Users.objects.get(USER_id=id)
    if 'photo' in request.FILES:
        photo = request.FILES['photo']
        fs = FileSystemStorage()
        date = datetime.now().strftime('%Y%m%d%H%M%S') + '.jpg'
        fs.save(date, photo)
        path = fs.url(date)
        obj.photo=path
        obj.save()
    obj.name = name
    obj.email = email
    obj.phone = phone
    obj.place = place
    obj.pin = pin
    obj.post = post
    obj.genter = genter
    obj.dob = dob
    obj.district = district
    obj.state = state
    obj.save()
    return JsonResponse({'status': 'ok'})


def user_change_password(request):
    id=request.POST['lid']
    currentpassword = request.POST['currentpassword']
    newpassword = request.POST['newpassword']
    confirmpassword = request.POST['confirmpassword']
    pass#(request.POST)
    user=User.objects.get(id=id)
    pass#(user,'userrrrrrrrrrrrrrr')
    # if user.check_password(currentpassword):
    pass#("aaaaaaaaaaaaaa")
    if newpassword == confirmpassword:
        print(currentpasswordgit)
        print(newpassword)
        user.set_password(newpassword)
        user.save()
        logout(request)
        return JsonResponse({'status': 'ok'})
    else:
        return JsonResponse({'status': 'no'})
    # else:
    #     return JsonResponse({'status': 'no'})

def user_view_bus(request):
    l = []
    a=Bus.objects.all()
    print(a,"Bus")

    for i in a:
        lat=""
        long=""
        if Loacation.objects.filter(DRIVER=i.DRIVER.id).exists():
            lat=Loacation.objects.get(DRIVER=i.DRIVER.id).latitude
            long=Loacation.objects.get(DRIVER=i.DRIVER.id).longitude
        l.append({
            'id':i.id,
            'busname':i.busname,
            'reg_no':i.reg_no,
            'FromROUTE':i.FromROUTE.strating,
            'To_ROUTE':i.To_ROUTE.destination,
            'description':i.description,
            'lat':lat,
            'long':long,
        })
    print(l,"bus")
    return JsonResponse({'status':'ok','data':l})


def user_view_seat(request):
    id=request.POST['bid']
    l=[]
    a=Seat.objects.filter(BUS=id)
    for i in a:
        l.append({
            'id':i.id,
            'seat_no':i.seat_no,
            'seat_type':i.seat_type,

        })
    print(l)
    return JsonResponse({
        'status':'ok',
        'data':l
    })

def user_sent_complaint(request):
    lid=request.POST['lid']
    complaint=request.POST['complaint']


    obj=Complaints()
    obj.date=datetime.now().today()
    obj.complaints=complaint
    obj.status='pending'
    obj.replay='pending'
    obj.USERS=Users.objects.get(USER=lid)
    obj.save()
    return JsonResponse({'status':'ok'})
def user_book_seat(request):
    lid=request.POST['lid']
    bid=request.POST['bid']
    seats=request.POST['seats']
    seat_list = json.loads(seats)

    print(lid,bid,seats,seat_list)
    for i in seat_list:
        print(i)
        obj=Booking()
        obj.USERS=Users.objects.get(USER=lid)
        obj.SEAT_id=i
        obj.date=datetime.now().date()
        obj.seat_no=1
        obj.save()
    return JsonResponse({'status':'ok'})

def user_view_complaint(request):
    lid=request.POST['lid']
    l=[]
    a=Complaints.objects.filter(USERS__USER=lid)
    for i in a:
        l.append({
            'id':i.id,
            'date':i.date,
            'complaint':i.complaints,
            'status':i.status,
            'replay':i.replay,
        })
    return JsonResponse({'status':'ok','data':l})

def user_sent_feedback(request):
    lid=request.POST['lid']
    feed=request.POST['feed']

    obj=Feedback()
    obj.date=datetime.now().today()
    obj.feedback=feed
    obj.USERS=Users.objects.get(USER=lid)
    obj.save()
    return JsonResponse({'status':'ok'})


def user_view_feedback(request):
    lid=request.POST['lid']
    l=[]
    a=Feedback.objects.filter(USERS__USER=lid)
    for i in a:
        l.append({
            'id':i.id,
            'date':i.date,
            'feed':i.feedback,

        })
    return JsonResponse({'status':'ok','data':l})





def get_stops(request):
    stops = Stop.objects.all().values('id', 'stop')
    return JsonResponse({"status": "ok", "data": list(stops)})



def search_buses(request):
    from_stop = request.POST['from_stop']
    to_stop = request.POST['to_stop']

    try:
        ticket = TicketPrize.objects.get(FROMSTOP__id=from_stop, TOSTOP__id=to_stop)
        price = ticket.amount
    except TicketPrize.DoesNotExist:
        price = "N/A"

    stops = Stop.objects.filter(id__in=[from_stop, to_stop])

    if len(stops) != 2:
        return JsonResponse({"status": "no", "message": "Invalid stops"})

    route = stops[0].ROUTE

    buses = Bus.objects.filter(FromROUTE=route)

    bus_list = []
    for b in buses:
        bus_list.append({
            "id": b.id,
            "busname": b.busname,
            "reg_no": b.reg_no,
            "driver": b.DRIVER.name,
            "description": b.description,
            "price": price
        })
    print(bus_list)
    return JsonResponse({"status": "ok", "data": bus_list})


# ----------------------------------------------------------
# 3. GET SEATS OF BUS
# ----------------------------------------------------------
# def user_view_seat(request):
#     bus_id = request.POST['bus_id']
#
#     seats = Seat.objects.filter(BUS__id=bus_id).values(
#         'id', 'seat_no', 'seat_type'
#     )
#
#     return JsonResponse({"status": "ok", "data": list(seats)})
#
# def user_view_seat(request):
#     bus_id = request.POST['bid']
#
#     try:
#         bus = Bus.objects.get(id=bus_id)
#         print(bus,'hello')
#     except Bus.DoesNotExist:
#         return JsonResponse({"status": "error", "message": "Bus not found"})
#
#     seats = Seat.objects.filter(BUS=bus).values('id', 'seat_no', 'seat_type')
#     print(seats,'hiii')
#
#     try:
#         ticket = TicketPrize.objects.filter(
#             FROMSTOP__ROUTE=bus.FromROUTE,
#             TOSTOP__ROUTE=bus.To_ROUTE
#         ).first()
#
#         if ticket:
#             price = float(ticket.amount)
#         else:
#             price = 0.0
#
#         price = float(ticket.amount)
#     except TicketPrize.DoesNotExist:
#         price = 0.0
#
#     data = []
#     for seat in seats:
#         booked = Booking.objects.filter(SEAT_id=seat["id"]).exists()
#         data.append({
#             "id": seat["id"],
#             "seat_no": seat["seat_no"],
#             "seat_type": seat["seat_type"],
#             "booked": booked,
#             "price": price
#         })
#
#     return JsonResponse({"status": "ok", "data": data})

def user_view_seat(request):
    bus_id = request.POST['bid']

    try:
        bus = Bus.objects.get(id=bus_id)
    except Bus.DoesNotExist:
        return JsonResponse({"status": "error", "message": "Bus not found"})

    seats = Seat.objects.filter(BUS=bus).values('id', 'seat_no', 'seat_type')

    ticket = TicketPrize.objects.filter(
        FROMSTOP__ROUTE=bus.FromROUTE,
        TOSTOP__ROUTE=bus.To_ROUTE
    ).first()

    price = float(ticket.amount) if ticket else 0.0

    data = []
    for seat in seats:
        booked = Booking.objects.filter(SEAT_id=seat["id"]).exists()
        data.append({
            "id": seat["id"],
            "seat_no": seat["seat_no"],
            "seat_type": seat["seat_type"],
            "booked": booked,
            "price": price
        })

    return JsonResponse({"status": "ok", "data": data})

# ----------------------------------------------------------
# 4. BOOK SELECTED SEATS
# ----------------------------------------------------------
# def user_book_seat(request):
#     user_id = request.POST['user_id']
#     seats_list = json.loads(request.POST['seats'])
#     amount=request.POST['amount']
#
#     user = Users.objects.get(USER_id=user_id)
#
#     for sid in seats_list:
#         seat = Seat.objects.get(id=sid)
#
#         Booking.objects.create(
#             date=datetime.now().today(),
#             seat_no=seat.seat_no,
#             SEAT=seat,
#             USERS=user,
#             amount=amount
#         )
#
#     return JsonResponse({"status": "ok", "message": "Booking successful"})



from datetime import datetime
from django.http import JsonResponse
import json
from .models import Users, Seat, Booking, TicketPrize
#
# def user_book_seat(request):
#     user_id = request.POST['user_id']
#     seats_list = json.loads(request.POST['seats'])
#     total_amount = float(request.POST['amount'])
#
#     user = Users.objects.get(USER_id=user_id)
#
#     for sid in seats_list:
#         seat = Seat.objects.get(id=sid)
#
#         try:
#             ticket = TicketPrize.objects.filter(
#                 FROMSTOP__ROUTE=seat.BUS.FromROUTE,
#                 TOSTOP__ROUTE=seat.BUS.To_ROUTE
#             ).first()
#
#             single_price = float(ticket.amount) if ticket else 0.0
#
#         except TicketPrize.DoesNotExist:
#             single_price = 0.0
#
#         Booking.objects.create(
#             date=datetime.now().strftime("%Y-%m-%d"),
#             seat_no=seat.seat_no,
#             SEAT=seat,
#             USERS=user,
#             amount=single_price
#         )
#
#     return JsonResponse({"status": "ok", "message": "Booking successful"})
#
from datetime import datetime
from django.http import JsonResponse
import json
from .models import Users, Seat, Booking, TicketPrize, Payment

def user_book_seat(request):
    user_id = request.POST['user_id']
    seats_list = json.loads(request.POST['seats'])
    total_amount = float(request.POST['amount'])

    user = Users.objects.get(USER_id=user_id)
    booking_ids = []

    for sid in seats_list:
        seat = Seat.objects.get(id=sid)

        ticket = TicketPrize.objects.filter(
            FROMSTOP__ROUTE=seat.BUS.FromROUTE,
            TOSTOP__ROUTE=seat.BUS.To_ROUTE
        ).first()
        single_price = float(ticket.amount) if ticket else 0.0

        booking = Booking.objects.create(
            date=datetime.now().strftime("%Y-%m-%d"),
            seat_no=seat.seat_no,
            SEAT=seat,
            USERS=user,
            amount=single_price
        )
        booking_ids.append(booking.id)

    return JsonResponse({
        "status": "ok",
        "message": "Booking created, proceed to payment",
        "booking_ids": booking_ids,
        "total_amount": total_amount
    })


def user_view_boooking(request):
    id= request.POST['lid']
    a =  Booking.objects.filter(USERS__USER_id=id)
    l=[]
    for i in a:
        l.append({
            'id':i.id,
            'date':i.date,
            'seat_no':i.seat_no,
            'amount':i.amount,
            'bus':i.SEAT.BUS.busname,
        })
    pass#(l)
    return JsonResponse({'status':'ok','data':l})

def makepayment(request):
    booking_ids = json.loads(request.POST['booking_ids'])
    payment_id = request.POST['payment_id']
    amount = request.POST['amount']

    for bid in booking_ids:
        booking = Booking.objects.get(id=bid)
        Payment.objects.create(
            BOOKING=booking,
            status='paid'
        )

    return JsonResponse({"status": "ok", "message": "Payment recorded successfully"})

def user_seat_payment(request):
    seat_ids = json.loads(request.POST['seat_ids'])
    lid = request.POST['lid']

    for sid in seat_ids:
        booking = Seat.objects.get(id=sid)
        Booking.objects.create(
            status='booked',
            SEAT=booking,
            amount="",
            date=datetime.now().date(),
            seat_no=1,
            USERS=Users.objects.get(USER=lid)
        )

    return JsonResponse({"status": "ok", "message": "Payment recorded successfully"})


def user_view_seat_boooking(request):
    bid= request.POST['bid']
    a =  Booking.objects.filter(SEAT__BUS_id=bid)

    l=[]
    for i in a:
        l.append({
            'id':i.id,
            'seatid':i.SEAT.id,
        })
    pass#(l)
    return JsonResponse({'status':'ok','data':l})
import random
def forgot_password(request):
    return render(request,'Forget_password.html')

def forgotpassword_post(request):


    email=request.POST['email']
    new_pass = random.randint(00000, 99999)
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login("ksrtcconnect@gmail.com", " gcocqohywyqseull")  # App Password
    to = email
    subject = "Test Email"
    body = f"""
    Hello,

    We received a request to reset your account password.

    Your temporary password is:

    {new_pass}

    Please log in using this password and change it immediately to ensure your account security.

    If you did not request this password reset, please ignore this email or contact our support team immediately.

    Thank you,
    KSRTC Connect Support Team
    """
    msg = f"Subject: {subject}\n\n{body}"
    server.sendmail("s@gmail.com", to, msg)  # Disconnect from the server
    server.quit()

    user = User.objects.get(username=email)
    user.set_password(str(new_pass))
    user.save()

    return redirect('/myapp/login_get/')






def android_forget_password_post(request):
    email = request.POST.get('email')
    if not email:
        return JsonResponse({'status': 'error', 'message': 'Email is required'})

    try:
        user = User.objects.get(username=email)
        pass#(email)

        # Generate new password
        new_pass = str(random.randint(1000, 9999))
        user.password = make_password(new_pass)
        user.save()

        # Email configuration
        smtp_server = "smtp.gmail.com"
        smtp_port = 587
        sender_email = "ksrtcconnect@gmail.com"
        app_password = "gcocqohywyqseull"

        subject = "Your New Password"
        body = f"""
        Hello,

        We received a request to reset your account password.

        Your temporary password is:

        {new_pass}

        Please log in using this password and change it immediately to ensure your account security.

        If you did not request this password reset, please ignore this email or contact our support team immediately.

        Thank you,
        KSRTC Connect Support Team
        """
        message = MIMEMultipart()
        message["From"] = sender_email
        message["To"] = email
        message["Subject"] = subject
        message.attach(MIMEText(body, "plain"))

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, app_password)
        server.send_message(message)
        server.quit()

        return JsonResponse({'status': 'ok', 'message': 'Password sent to your email'})

    except User.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Email not found'})

    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Email send error: {str(e)}'})


