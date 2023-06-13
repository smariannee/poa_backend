import nodemailer from 'nodemailer';

export const transporter = nodemailer.createTransport({
    host: process.env.HOST_EMAIL,
    port: parseInt(process.env.PORT_EMAIL || '624'),
    secure: true,
    auth: {
        user: process.env.EMAIL_ADDRESS,
        pass: process.env.EMAIL_PASSWORD,
    },
});

transporter.verify().then(() => {
    console.log('Ready for send emails')
}).catch(error => {
    console.log(error)
});