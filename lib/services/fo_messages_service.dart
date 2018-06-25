import 'package:angular/di.dart';
import 'package:intl/intl.dart';

@Injectable()
class FoMessagesService {
  String add() => Intl.message('add', name: 'add');

  String back() => Intl.message('back', name: 'back');

  String cancel() => Intl.message('cancel', name: 'cancel');

  String comments(int howMany) =>
      Intl.plural(howMany, one: 'comment', other: 'comments', name: 'comments');

  String confirm() => Intl.message('confirm', name: 'confirm');

  String confirm_delete_resource() =>
      Intl.message('Are you sure you want to delete this resource?', name: 'confirm_delete_resource');

  String description() => Intl.message('description', name: 'description');

  String download_csv() => Intl.message('download .CSV file', name: 'donwload_csv');

  String email() => Intl.message('email', name: 'email');

  String enter_email() => Intl.message('enter a valid email', name: 'enter_email');

  String enter_firstname() => Intl.message('enter a firstname', name: 'enter_firstname');

  String enter_lastname() => Intl.message('enter a lastname', name: 'enter_lastname');

  String enter_phone() => Intl.message('enter a valid phone', name: 'enter_phone');

  String enter_value() => Intl.message('enter a value', name: 'enter_value');

  String filter() => Intl.message('filter', name: 'filter');

  String filter_enter() => Intl.message('filter (press enter to apply)', name: 'filter_enter');

  String firstname() => Intl.message('firstname', name: 'firstname');

  String forgot_password() => Intl.message('forgot password', name: 'forgot_password');

  String forgot_password_description() => Intl.message(
      'Enter your username and press send to begin resetting your password',
      name: 'forgot_password_description',
      desc:
          'Direction on steps to take if the user wishes to restore his password, shown in FoLoginComponent under forgot password section');

  String gdpr_change_my_info() =>
      Intl.message('I wish to change/update my information', name: 'gdpr_change_my_info');

  String gdpr_erase_me() => Intl.message('I wish to erase all my data', name: 'gdpr_erase_me');

  String gdpr_fetch_my_info() =>
      Intl.message('I want to know my personal details', name: 'gdpr_fetch_my_info');

  String gdpr_fetch_my_info_portable() =>
      Intl.message('I want to access my personal details in a portable data', name: 'gdpr_fetch_my_info_portable');

  String gdpr_form_accept() => Intl.message(
      'I hereby consent that above details are stored while the case is processed',
      name: 'gdpr_form_accept',
      desc:
          'Label next to checkbox that the user must check in order to submit an issue');

  String gdpr_form_completed_message() => Intl.message(
      '<h1>Thank you!</h1><p>Your inquiry has been now been sent, and we will take necessary actions and reply to you as soon as we can.</p>',
      name: 'gdpr_form_completed_message',
      desc:
          'Displayed to the user after submitting the gdpr form, can be basic html');

  String gdpr_form_info() => Intl.message(
      'This form is used for inquiries regarding your rights in accordance with Data Protection Regulation 2016/79.<br /><br />We save the details you provide in accordance with article 17.3.<br /><br />This information is sent to the support contact who registered your details and is logged by the service provider.',
      name: 'gdpr_form_info',
      desc: 'Text displayed over the GDPR issue form');

  String gdpr_limit_my_data_processing() =>
      Intl.message('I wish to limit how my data is being processed', name: 'gdpr_limit_my_data_processing');

  String gdpr_oppose_my_data_processing() =>
      Intl.message('I wish to oppose how my data is being processed', name: 'gdpr_oppose_my_data_processing');

  String information() => Intl.message('information', name: 'information');

  String invalid_file() => Intl.message('invalid file', name: 'invalid_file');

  String issue(int howMany) =>
      Intl.plural(howMany, one: 'issue', other: 'issues', name: 'issue');

  String lastname() => Intl.message('lastname', name: 'lastname');

  String login() => Intl.message('log in', name: 'login');

  String max_filesize_exceeded() => Intl.message('max filesize exceeded', name: 'max_filesize_exceeded');

  String new_password() => Intl.message('new password', name: 'new_password');

  String no_results_found() => Intl.message('no results found', name: 'no_results_found');

  String ok() => Intl.message('ok', name: 'ok');

  String page(int howMany) =>
      Intl.plural(howMany, one: 'page', other: 'pages', name: 'page');

  String password() => Intl.message('password', name: 'password');

  String phone() => Intl.message('phone number', name: 'phone');

  String read_more() => Intl.message('read more', name: 'read_more');

  String reset_password() => Intl.message('reset password', name: 'reset_password');

  String reset_password_description() => Intl.message(
      'We have sent an ${email()} with a reset key to you. Paste it below to update your password.',
      name: 'reset_password_description',
      desc: 'Displayed to the user have he has requested a new password');

  String row(int howMany) =>
      Intl.plural(howMany, one: 'row', other: 'rows', name: 'row');

  String save() => Intl.message('save', name: 'save');

  String search() => Intl.message('search', name: 'search');

  String select() => Intl.message('select', name: 'select');

  String send() => Intl.message('send', name: 'send');

  String token() => Intl.message('token', name: 'token');

  String username() => Intl.message('username', name: 'username');
}
