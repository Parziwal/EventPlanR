namespace EventPlanr.Application.Models.Ticket;

public class TicketStatisticsDto
{
    public Guid Id { get; set; }
    public string TicketName { get; set; } = null!;
    public int TotalTicketCount { get; set; }
    public int SoldTicketCount { get; set; }
    public int CheckedInTicketCount { get; set; }
}
