namespace EventPlanr.Application.Models.Order;

public class AddTicketUserInfoDto
{
    public Guid TicketId { get; set; }
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
}
