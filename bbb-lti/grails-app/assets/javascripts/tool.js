/*
    BigBlueButton open source conferencing system - http://www.bigbluebutton.org/

    Copyright (c) 2012 BigBlueButton Inc. and by respective authors (see below).

    This program is free software; you can redistribute it and/or modify it under the
    terms of the GNU Lesser General Public License as published by the Free Software
    Foundation; either version 3.0 of the License, or (at your option) any later
    version.

    BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
    PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License along
    with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
*/
$(document).ready( function () {
	if (typeof jQuery !== 'undefined') {
		(function($) {
			$('#spinner').ajaxStart(function() {
				$(this).fadeIn();
			}).ajaxStop(function() {
				$(this).fadeOut();
			});
		})(jQuery);
		
		$('#recordings').dataTable({
			columnDefs: [ {
				targets: 3,
				render: $.fn.dataTable.render.moment('X', 'LLL', locale)
			} ],
			sPaginationType : "full_numbers",
			"columns": [
				null,
				null,
				null,
				null,
				null,
				{ "width": "160px" }
			],
			"order": [[ 3, "desc" ]]
		});
		
	}
});
