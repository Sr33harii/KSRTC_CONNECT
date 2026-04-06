from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Driver(models.Model):
    licenceno = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    pin = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    genter = models.CharField(max_length=100)
    dob = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    photo = models.CharField(max_length=500,default='')
    USER = models.OneToOneField(User, on_delete=models.CASCADE)


class Users(models.Model):
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    pin = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    genter = models.CharField(max_length=100)
    dob = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    photo = models.CharField(max_length=500, default='')
    USER = models.OneToOneField(User, on_delete=models.CASCADE,default=1)




class Route(models.Model):
    strating = models.CharField(max_length=100)
    destination = models.CharField(max_length=100)


class Stop(models.Model):
    stop = models.CharField(max_length=100)
    ROUTE = models.ForeignKey(Route, on_delete=models.CASCADE)


class Complaints(models.Model):
    complaints = models.CharField(max_length=100)
    status = models.CharField(max_length=100)
    replay = models.CharField(max_length=100)
    USERS = models.ForeignKey(Users, on_delete=models.CASCADE)
    date = models.CharField(max_length=100)


class Feedback(models.Model):
    feedback=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    USERS = models.ForeignKey(Users, on_delete=models.CASCADE)

class Bus(models.Model):
    busname=models.CharField(max_length=100)
    reg_no=models.CharField(max_length=100)
    FromROUTE=models.ForeignKey(Route, on_delete=models.CASCADE,default='',related_name='to_route')
    To_ROUTE=models.ForeignKey(Route, on_delete=models.CASCADE,default='',related_name='from_route')
    description=models.CharField(max_length=100)
    DRIVER=models.ForeignKey(Driver, on_delete=models.CASCADE)
class Seat(models.Model):
    seat_no=models.CharField(max_length=100)
    seat_type=models.CharField(max_length=100)
    BUS=models.ForeignKey(Bus, on_delete=models.CASCADE)

class TicketPrize(models.Model):
    FROMSTOP=models.ForeignKey(Stop,on_delete=models.CASCADE,related_name='from_stop')
    TOSTOP=models.ForeignKey(Stop,on_delete=models.CASCADE,related_name='to_stop')
    amount=models.CharField(max_length=100)




class Booking(models.Model):
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=100,default='pending')
    seat_no=models.IntegerField()
    amount=models.CharField(max_length=100,default='')
    SEAT=models.ForeignKey(Seat, on_delete=models.CASCADE)
    USERS=models.ForeignKey(Users,on_delete=models.CASCADE)

class Payment(models.Model):
    BOOKING=models.ForeignKey(Booking, on_delete=models.CASCADE)
    status=models.CharField(max_length=100,default='pending')


class Loacation(models.Model):
    latitude=models.CharField(max_length=100)
    longitude=models.CharField(max_length=100)
    DRIVER=models.ForeignKey(Driver, on_delete=models.CASCADE)