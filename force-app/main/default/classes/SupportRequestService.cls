public without sharing class SupportRequestService {

    // Constantes de estado y prioridad
    public static final String STATUS_TO_MANAGE = 'ToManage';
    public static final String PRIORITY_HIGH = 'High';
    public static final String PRIORITY_MEDIUM = 'Medium';
    public static final String PRIORITY_LOW = 'Low';

    // Constantes de días según prioridad
    public static final Integer DIAS_HIGH = 1;
    public static final Integer DIAS_MEDIUM = 3;
    public static final Integer DIAS_LOW_O_DEFAULT = 5;

    /**
     * Método para sumar días hábiles a una fecha inicial.
     * 
     * @param fechaBase Fecha a la que se le sumarán los días hábiles.
     * @param diasAniadir Número de días hábiles a sumar.
     * @return Fecha resultante después de sumar los días hábiles.
     */
    public static Date sumarDiasHabiles(Date fechaBase, Integer diasAniadir) {
        Integer diasSumados = 0;
        Date fechaResultante = fechaBase;

        while (diasSumados < diasAniadir) {
            fechaResultante = fechaResultante.addDays(1);
            if (fechaResultante.toStartOfWeek().addDays(5) > fechaResultante) { // Lunes a viernes
                diasSumados++;
            }
        }

        return fechaResultante;
    }

    /**
     * Método para modificar la fecha de resolución de soporte con las solicitudes.
     * 
     * @param requests Lista de solicitudes de soporte a procesar.
     */
    public static void actualizarFechaSupportRequests(List<SupportRequest__c> requests) {
        for (SupportRequest__c req : requests) {
            Integer diasAniadir = DIAS_LOW_O_DEFAULT;
            if (req.Priority__c == PRIORITY_HIGH) {
                diasAniadir = DIAS_HIGH;
            } else if (req.Priority__c == PRIORITY_MEDIUM) {
                diasAniadir = DIAS_MEDIUM;
            }
            req.ExpectedResolutionDate__c = sumarDiasHabiles(Date.today(), diasAniadir);
        }
    }

    public static void actualizarProcesarSupportRequests(Map<Id, SupportRequest__c> mNewMap, Map<Id, SupportRequest__c> mOldMap) {
        if (mNewMap.keySet() != null && !mNewMap.keySet().isEmpty() && mOldMap.keySet() != null && !mOldMap.keySet().isEmpty()) {

            // Si hay actualizaciones en algun registro, se comprueba si el cambio esta en el campo de estado por que si cambia a "ToManage" debe actualizar la fecha
            List<SupportRequest__c> requests = new List<SupportRequest__c>();
            for (SupportRequest__c req : mNewMap.values()) {
                if (mNewMap.get(req.Id) != null && mOldMap.get(req.Id) != null){
                    Integer diasAniadir = DIAS_LOW_O_DEFAULT;
                    // Verifica si el estado ha cambiado a "ToManage" para calcular la fecha de resolución
                    if (mNewMap.get(req.Id).Status__c != mOldMap.get(req.Id).Status__c && mNewMap.get(req.Id).Status__c == STATUS_TO_MANAGE) {
                        requests.add(req);
                    } else if (mNewMap.get(req.Id).ExpectedResolutionDate__c != mOldMap.get(req.Id).ExpectedResolutionDate__c) { // Verifica si cambia la fecha de resolución
                        requests.add(req);
                    }
                }
            }

            if (!requests.isEmpty()) {
               actualizarFechaSupportRequests(requests);
            }
        }
    }
}