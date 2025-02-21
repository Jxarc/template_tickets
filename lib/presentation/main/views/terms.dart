import 'package:flutter/material.dart';
import 'package:template/presentation/main/main_provider.dart';
import 'package:template/presentation/ui/ui.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    const terms = '''
El presente contrato describe los términos y condiciones aplicables al uso del contenido, 
productos y/o servicios del app C-Factura del cual es titular Rubén Pérez Pérez. 
Para hacer uso del contenido, productos y/o servicios del sitio web el usuario deberá sujetarse a los presentes términos y condiciones. 
I. OBJETO El objeto es regular el acceso y utilización del contenido, productos y/o servicios a disposición del público en general de C-Factura. El titular se 
reserva el derecho de realizar cualquier tipo de modificación en el app en cualquier momento y sin previo aviso, el usuario acepta dichas modificaciones. 
El acceso al sitio web por parte del usuario es libre y gratuito, la utilización del contenido, productos y/o servicios implica un costo de suscripción para 
el usuario. El sitio web solo admite el acceso a personas mayores de edad y no se hace responsable por el incumplimiento de esto. El sitio web está dirigido 
a usuarios residentes en Chile y cumple con la legislación establecida en dicho país, si el usuario reside en otro país y decide acceder al sitio web lo 
hará bajo su responsabilidad. La administración del sitio web puede ejercerse por terceros, es decir, personas distintas al titular, sin afectar esto 
los presentes términos y condiciones. II. USUARIO La actividad del usuario en el sitio web como publicaciones o comentarios estarán sujetos a los presentes 
términos y condiciones. El usuario se compromete a utilizar el contenido, productos y/o servicios de forma lícita, sin faltar a la moral o al orden público, 
absteniéndose de realizar cualquier acto que afecte los derechos de terceros o el funcionamiento del sitio web. El usuario se compromete a proporcionar 
información verídica en los formularios del sitio web. El acceso al sitio web no supone una relación entre el usuario y el titular del sitio web. El usuario manifiesta ser mayor de edad y contar con la capacidad jurídica de acatar los presentes términos y condiciones. III. ACCESO Y NAVEGACIÓN EN EL SITIO WEB El titular no garantiza la continuidad y disponibilidad del contenido, productos y/o servicios en el sitito web, realizará acciones que fomenten el buen funcionamiento de dicho sitio web sin responsabilidad alguna. El titular no se responsabiliza de que el software esté libre de errores que puedan causar un daño al software y/o hardware del equipo del cual el usuario accede al sitio web. De igual forma, no se responsabiliza por los daños causados por el acceso y/o utilización del sitio web. IV. POLÍTICA DE PRIVACIDAD Y PROTECCIÓN DE DATOS Conforme a lo establecido en la Ley Federal de Protección de Datos Personales en Posesión de Particulares, el titular de compromete a tomar las medidas necesarias que garanticen la seguridad del usuario, evitando que se haga uso indebido de los datos personales que el usuario proporcione en el sitio web. El titular corroborará que los datos personales contenidos en las bases de datos sean correctos, verídicos y actuales, así como que se utilicen únicamente con el fin con el que fueron recabados. El uso de datos personales se limitará a lo previsto en el Aviso de Privacidad disponible en https://www.milformatos.com/aviso-de-privacidad. Mil Formatos se reserva el derecho de realizar cualquier tipo de modificación en el Aviso de Privacidad en cualquier momento y sin previo aviso, de acuerdo con sus necesidades o cambios en la legislación aplicable, el usuario acepta dichas modificaciones. El sitio web implica la utilización de cookies que son pequeñas cantidades de información que se almacenan en el navegador utilizado por el usuario como datos de ingreso, preferencias del usuario, fecha y hora en que se accede al sitio web, sitios visitados y dirección IP, esta información es anónima y solo se utilizará para mejorar el sitio web. Los cookies facilitan la navegación y la hacen más amigable, sin embargo, el usuario puede desactivarlos en cualquier momento desde su navegador en el entendido de que esto puede afectar algunas funciones del sitio web.
''';
    return Scaffold(
      appBar: CLGAppBar(title: 'Términos y condiciones'),
      body: ColoredBox(
        color: context.theme.background.shade700,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: CLGText(
                      terms,
                      textAlign: TextAlign.start,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.black,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CLGButton(
                      color: context.theme.background.shade700,
                      borderColor: context.theme.primary,
                      textColor: context.theme.primary,
                      borderWidth: 1,
                      onClick: () {},
                      text: 'Rechazar',
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CLGButton(
                      onClick: () {
                        MainProvider.read(context).isTermsAccepted = true;
                      },
                      text: 'Aceptar',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
