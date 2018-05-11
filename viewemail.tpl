<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>{$LANG.clientareaemails} - {$companyname}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="templates/{$template}/assets/css/bootstrap-hexa.min.css" rel="stylesheet">
	<link href="templates/{$template}/assets/css/style.css" rel="stylesheet">
	{if $hexa_extras_style}<link rel='stylesheet' href="{$WEB_ROOT}/templates/{$template}/assets/css/skins/{$hexa_extras_style}" />
	{else}
	<link rel='stylesheet' href="{$WEB_ROOT}/templates/{$tehexa_extras_stylemplate}/assets/css/skins/city.min.css" />
	{/if}
</head>
<body style="background:#fff;">
	<div class="container">
		<div class="row py-1">
			<div class="col-md-12">
				<h3 class="text-center">{$subject}</h3>
				<div class="well well-lg">
					{$message}
				</div>
				<div class="form-group text-center">
					<input type="button" value="{$LANG.closewindow}" class="btn btn-primary" onclick="window.close()" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>
