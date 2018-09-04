import 'package:angular/di.dart';
import 'package:intl/intl.dart';

@Injectable()
class FoMessagesService {
  String add() => Intl.message('add', name: 'FoMessagesService_add');

  String back() => Intl.message('back', name: 'FoMessagesService_back');

  String cancel() => Intl.message('cancel', name: 'FoMessagesService_cancel');

  String comments(int howMany) => Intl.plural(howMany,
      one: 'comment',
      other: 'comments',
      args: [howMany],
      name: 'FoMessagesService_comments');

  String confirm() =>
      Intl.message('confirm', name: 'FoMessagesService_confirm');

  String confirm_delete_resource() =>
      Intl.message('Are you sure you want to delete this resource?',
          name: 'FoMessagesService_confirm_delete_resource');

  String day(int howMany) => Intl.plural(howMany,
      one: 'day',
      other: 'days',
      args: [howMany],
      name: 'FoMessagesService_day');

  String description() =>
      Intl.message('description', name: 'FoMessagesService_description');

  String download_csv() => Intl.message('download .CSV file',
      name: 'FoMessagesService_download_csv');

  String email() => Intl.message('email', name: 'FoMessagesService_email');

  String enter_email() => Intl.message('enter a valid email',
      name: 'FoMessagesService_enter_email');

  String enter_firstname() => Intl.message('enter a firstname',
      name: 'FoMessagesService_enter_firstname');

  String enter_lastname() => Intl.message('enter a lastname',
      name: 'FoMessagesService_enter_lastname');

  String enter_phone() => Intl.message('enter a valid phone',
      name: 'FoMessagesService_enter_phone');

  String enter_value() =>
      Intl.message('enter a value', name: 'FoMessagesService_enter_value');

  String filter() => Intl.message('filter', name: 'FoMessagesService_filter');

  String filter_enter() => Intl.message('filter (press enter to apply)',
      name: 'FoMessagesService_filter_enter');

  String firstname() =>
      Intl.message('firstname', name: 'FoMessagesService_firstname');

  String forgot_password() => Intl.message('forgot password',
      name: 'FoMessagesService_forgot_password');

  String forgot_password_description() => Intl.message(
      'Enter your username and press send to begin resetting your password',
      name: 'FoMessagesService_forgot_password_description',
      desc:
          'Direction on steps to take if the user wishes to restore his password, shown in FoLoginComponent under forgot password section');

  String gdpr_change_my_info() =>
      Intl.message('I wish to change/update my information',
          name: 'FoMessagesService_gdpr_change_my_info');

  String gdpr_erase_me() => Intl.message('I wish to erase all my data',
      name: 'FoMessagesService_gdpr_erase_me');

  String gdpr_fetch_my_info() =>
      Intl.message('I want to know my personal details',
          name: 'FoMessagesService_gdpr_fetch_my_info');

  String gdpr_fetch_my_info_portable() =>
      Intl.message('I want to access my personal details in a portable data',
          name: 'FoMessagesService_gdpr_fetch_my_info_portable');

  String gdpr_form_accept() => Intl.message(
      'I hereby consent that above details are stored while the case is processed',
      name: 'FoMessagesService_gdpr_form_accept',
      desc:
          'Label next to checkbox that the user must check in order to submit an issue');

  String gdpr_form_completed_message() => Intl.message(
      '<h1>Thank you!</h1><p>Your inquiry has been now been sent, and we will take necessary actions and reply to you as soon as we can.</p>',
      name: 'FoMessagesService_gdpr_form_completed_message',
      desc:
          'Displayed to the user after submitting the gdpr form, can be basic html');

  String gdpr_form_info() => Intl.message(
      'This form is used for inquiries regarding your rights in accordance with Data Protection Regulation 2016/79.<br /><br />We save the details you provide in accordance with article 17.3.<br /><br />This information is sent to the support contact who registered your details and is logged by the service provider.',
      name: 'FoMessagesService_gdpr_form_info',
      desc: 'Text displayed over the GDPR issue form');

  String gdpr_limit_my_data_processing() =>
      Intl.message('I wish to limit how my data is being processed',
          name: 'FoMessagesService_gdpr_limit_my_data_processing');

  String gdpr_oppose_my_data_processing() =>
      Intl.message('I wish to oppose how my data is being processed',
          name: 'FoMessagesService_gdpr_oppose_my_data_processing');

  String information() =>
      Intl.message('information', name: 'FoMessagesService_information');

  String invalid_details() =>
      Intl.message('invalid username/password', name: 'invalid_details');

  String invalid_file() =>
      Intl.message('invalid file', name: 'FoMessagesService_invalid_file');

  String issue(int howMany) => Intl.plural(howMany,
      one: 'issue',
      other: 'issues',
      args: [howMany],
      name: 'FoMessagesService_issue');

  String lastname() =>
      Intl.message('lastname', name: 'FoMessagesService_lastname');

  String login() => Intl.message('log in', name: 'FoMessagesService_login');

  String max_filesize_exceeded() => Intl.message('max filesize exceeded',
      name: 'FoMessagesService_max_filesize_exceeded');

  String month(int howMany) => Intl.plural(howMany,
      one: 'month',
      other: 'months',
      args: [howMany],
      name: 'FoMessagesService_month');

  String new_password() =>
      Intl.message('new password', name: 'FoMessagesService_new_password');

  String no_results_found() => Intl.message('no results found',
      name: 'FoMessagesService_no_results_found');

  String ok() => Intl.message('ok', name: 'FoMessagesService_ok');

  String page(int howMany) => Intl.plural(howMany,
      one: 'page',
      other: 'pages',
      args: [howMany],
      name: 'FoMessagesService_page');

  String password() =>
      Intl.message('password', name: 'FoMessagesService_password');

  String phone() =>
      Intl.message('phone number', name: 'FoMessagesService_phone');

  String read_more() =>
      Intl.message('read more', name: 'FoMessagesService_read_more');

  String reset_password() =>
      Intl.message('reset password', name: 'FoMessagesService_reset_password');

  String reset_password_description() => Intl.message(
      'We have sent an email with a reset key to you. Paste it below to update your password.',
      name: 'FoMessagesService_reset_password_description',
      desc: 'Displayed to the user have he has requested a new password');

  String row(int howMany) => Intl.plural(howMany,
      one: 'row',
      other: 'rows',
      args: [howMany],
      name: 'FoMessagesService_row');

  String save() => Intl.message('save', name: 'FoMessagesService_save');

  String search() => Intl.message('search', name: 'FoMessagesService_search');

  String select() => Intl.message('select', name: 'FoMessagesService_select');

  String send() => Intl.message('send', name: 'FoMessagesService_send');

  String ssn() => Intl.message('social number', name: 'FoMessagesService_ssn');

  String token() => Intl.message('token', name: 'FoMessagesService_token');

  String username() =>
      Intl.message('username', name: 'FoMessagesService_username');

  String with_selected() =>
      Intl.message('with selected', name: 'with_selected');

  String year(int howMany) => Intl.plural(howMany,
      one: 'year',
      other: 'years',
      args: [howMany],
      name: 'FoMessagesService_year');
}
