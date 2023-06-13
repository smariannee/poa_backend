export const templateNewUser = (email: string, password: string) => (
`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office" style="font-family:arial, 'helvetica neue', helvetica, sans-serif">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1" name="viewport">
    <meta name="x-apple-disable-message-reformatting">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="telephone=no" name="format-detection">
    <title>Bienvenido a POA</title>
</head>
<body>
    <h1>Bienvenido a POA</h1>
    <p>Estimado usuario, se le ha creado una cuenta en el sistema POA.</p>
    <p>Para acceder al sistema, utilice las siguientes credenciales:</p>
    <p>Correo electrónico: ${email}</p>
    <p>Contraseña: ${password}</p>
</body>
</html>`
)