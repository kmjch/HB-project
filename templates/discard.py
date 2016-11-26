user = User.query.filter_by(username=username).one()
dictionary = {}

for i in range(len(user.user_exps)):
    list_ratings = zip(user.user_exps[i].rating, user.user_exps[i].rating)
rest_zip = sorted(list_ratings), range(len(user.user_exps))
session['username'] = user.username

return render_template("user.html",
                       user=user,
                       loop=rest_zip,
                       list_ratings=list_ratings)


user = db.relationship("User", backref='user_exps',
                       lazy='dynamic', uselist='True',
                       order_by='UserExp.rating.desc()')


for i in range(len(user.user_exps)):
    list_ratings.append(tuple(user.user_exps[i].rating, user.user_exps[i].visit.restaurant.name))



user = User.query.filter_by(username=username).one()
rest_zip = zip(user.user_exps, range(len(user.user_exps)))
session['username'] = user.username

return render_template("user.html",
                       user=user,
                       loop=rest_zip)

{% for vis, i in loop %}
    {{ i + 1 }}. {{ vis.visit.restaurant.name }} : {{ vis.rating }}<br>
{% endfor %}