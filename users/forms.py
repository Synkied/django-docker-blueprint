from core.constants import GENDERS

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.utils.translation import gettext_lazy as _

from timezone_field import TimeZoneFormField

from users.models import User


class SignUpForm(UserCreationForm):
    """
    Simple sign up form.
    """
    def __init__(self, *args, **kwargs):
        """
        Add default CSS-class to display Bootstrap style form.
        """
        super(SignUpForm, self).__init__(*args, **kwargs)
        for field in self.visible_fields():
            field.field.widget.attrs['class'] = 'form-control'

    gender = forms.ChoiceField(
        choices=GENDERS,
        required=False,
        help_text=_('Optional.')
    )
    email = forms.EmailField(
        max_length=254,
        help_text=_('Required. Enter a valid email address.')
    )
    timezone = TimeZoneFormField()

    class Meta:
        model = User
        fields = (
            'name', 'gender', 'email',
            'password1', 'password2', 'timezone',
        )
