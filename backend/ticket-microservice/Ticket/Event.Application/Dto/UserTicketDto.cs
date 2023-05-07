namespace Ticket.Application.Dto;

public class UserTicketDto
{
    public string Id { get; set; } = default!;
    public string TicketName { get; set; } = default!;
    public int Quantity { get; set; }
}
