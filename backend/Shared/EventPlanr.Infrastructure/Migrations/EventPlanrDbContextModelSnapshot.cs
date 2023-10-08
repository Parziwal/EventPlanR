﻿// <auto-generated />
using System;
using System.Collections.Generic;
using EventPlanr.Infrastructure.Persistance;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace EventPlanr.Infrastructure.Migrations
{
    [DbContext(typeof(EventPlanrDbContext))]
    partial class EventPlanrDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.11")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("EventPlanr.Domain.Entities.EventEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Category")
                        .HasColumnType("integer");

                    b.Property<string>("CoverImageUrl")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<int>("Currency")
                        .HasColumnType("integer");

                    b.Property<string>("Description")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset>("FromDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<bool>("IsPrivate")
                        .HasColumnType("boolean");

                    b.Property<bool>("IsPublished")
                        .HasColumnType("boolean");

                    b.Property<int>("Language")
                        .HasColumnType("integer");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<Guid>("OrganizationId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("ToDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Venue")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.HasKey("Id");

                    b.HasIndex("OrganizationId");

                    b.ToTable("events", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.InvitationEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<Guid>("EventId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<int>("Status")
                        .HasColumnType("integer");

                    b.Property<string>("UserEmail")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("character varying(128)");

                    b.Property<string>("UserId")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("EventId");

                    b.ToTable("invitations", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.NewsPostEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<Guid>("EventId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Text")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("EventId");

                    b.ToTable("news_posts", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.OrderEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<int>("Currency")
                        .HasColumnType("integer");

                    b.Property<string>("CustomerFirstName")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("CustomerLastName")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<Guid>("CustomerUserId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<double>("Total")
                        .HasColumnType("double precision");

                    b.HasKey("Id");

                    b.ToTable("orders", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.OrganizationEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<DateTimeOffset?>("DeletedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Description")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<bool>("IsDeleted")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<List<Guid>>("MemberUserIds")
                        .IsRequired()
                        .HasColumnType("uuid[]");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("ProfileImageUrl")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("organizations", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.SoldTicketEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("OrderId")
                        .HasColumnType("uuid");

                    b.Property<double>("Price")
                        .HasColumnType("double precision");

                    b.Property<Guid>("TicketId")
                        .HasColumnType("uuid");

                    b.Property<string>("UserFirstName")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<string>("UserLastName")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.HasKey("Id");

                    b.HasIndex("OrderId");

                    b.HasIndex("TicketId");

                    b.ToTable("sold_tickets", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.TicketEntity", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Count")
                        .HasColumnType("integer");

                    b.Property<DateTimeOffset>("Created")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<Guid>("EventId")
                        .HasColumnType("uuid");

                    b.Property<DateTimeOffset>("LastModified")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("LastModifiedBy")
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(64)
                        .HasColumnType("character varying(64)");

                    b.Property<double>("Price")
                        .HasColumnType("double precision");

                    b.Property<int>("RemainingCount")
                        .HasColumnType("integer");

                    b.Property<DateTimeOffset>("SaleEnds")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTimeOffset>("SaleStarts")
                        .HasColumnType("timestamp with time zone");

                    b.HasKey("Id");

                    b.HasIndex("EventId");

                    b.ToTable("tickets", (string)null);
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.EventEntity", b =>
                {
                    b.HasOne("EventPlanr.Domain.Entities.OrganizationEntity", "Organization")
                        .WithMany("Events")
                        .HasForeignKey("OrganizationId");

                    b.OwnsOne("EventPlanr.Domain.Common.Coordinates", "Coordinates", b1 =>
                        {
                            b1.Property<Guid>("EventEntityId")
                                .HasColumnType("uuid");

                            b1.Property<double>("Latitude")
                                .HasColumnType("double precision");

                            b1.Property<double>("Longitude")
                                .HasColumnType("double precision");

                            b1.HasKey("EventEntityId");

                            b1.ToTable("events");

                            b1.WithOwner()
                                .HasForeignKey("EventEntityId");
                        });

                    b.OwnsOne("EventPlanr.Domain.Common.Address", "Address", b1 =>
                        {
                            b1.Property<Guid>("EventEntityId")
                                .HasColumnType("uuid");

                            b1.Property<string>("AddressLine")
                                .IsRequired()
                                .HasMaxLength(256)
                                .HasColumnType("character varying(256)");

                            b1.Property<string>("City")
                                .IsRequired()
                                .HasMaxLength(64)
                                .HasColumnType("character varying(64)");

                            b1.Property<string>("Country")
                                .IsRequired()
                                .HasMaxLength(64)
                                .HasColumnType("character varying(64)");

                            b1.Property<string>("ZipCode")
                                .IsRequired()
                                .HasMaxLength(10)
                                .HasColumnType("character varying(10)");

                            b1.HasKey("EventEntityId");

                            b1.ToTable("events");

                            b1.WithOwner()
                                .HasForeignKey("EventEntityId");
                        });

                    b.Navigation("Address")
                        .IsRequired();

                    b.Navigation("Coordinates")
                        .IsRequired();

                    b.Navigation("Organization");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.InvitationEntity", b =>
                {
                    b.HasOne("EventPlanr.Domain.Entities.EventEntity", "Event")
                        .WithMany("Invitations")
                        .HasForeignKey("EventId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Event");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.NewsPostEntity", b =>
                {
                    b.HasOne("EventPlanr.Domain.Entities.EventEntity", "Event")
                        .WithMany("NewsPosts")
                        .HasForeignKey("EventId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Event");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.OrderEntity", b =>
                {
                    b.OwnsOne("EventPlanr.Domain.Common.Address", "BillingAddress", b1 =>
                        {
                            b1.Property<Guid>("OrderEntityId")
                                .HasColumnType("uuid");

                            b1.Property<string>("AddressLine")
                                .IsRequired()
                                .HasMaxLength(256)
                                .HasColumnType("character varying(256)");

                            b1.Property<string>("City")
                                .IsRequired()
                                .HasMaxLength(64)
                                .HasColumnType("character varying(64)");

                            b1.Property<string>("Country")
                                .IsRequired()
                                .HasMaxLength(64)
                                .HasColumnType("character varying(64)");

                            b1.Property<string>("ZipCode")
                                .IsRequired()
                                .HasMaxLength(10)
                                .HasColumnType("character varying(10)");

                            b1.HasKey("OrderEntityId");

                            b1.ToTable("orders");

                            b1.WithOwner()
                                .HasForeignKey("OrderEntityId");
                        });

                    b.Navigation("BillingAddress")
                        .IsRequired();
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.SoldTicketEntity", b =>
                {
                    b.HasOne("EventPlanr.Domain.Entities.OrderEntity", "Order")
                        .WithMany("SoldTickets")
                        .HasForeignKey("OrderId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EventPlanr.Domain.Entities.TicketEntity", "Ticket")
                        .WithMany("SoldTickets")
                        .HasForeignKey("TicketId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Order");

                    b.Navigation("Ticket");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.TicketEntity", b =>
                {
                    b.HasOne("EventPlanr.Domain.Entities.EventEntity", "Event")
                        .WithMany("Tickets")
                        .HasForeignKey("EventId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Event");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.EventEntity", b =>
                {
                    b.Navigation("Invitations");

                    b.Navigation("NewsPosts");

                    b.Navigation("Tickets");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.OrderEntity", b =>
                {
                    b.Navigation("SoldTickets");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.OrganizationEntity", b =>
                {
                    b.Navigation("Events");
                });

            modelBuilder.Entity("EventPlanr.Domain.Entities.TicketEntity", b =>
                {
                    b.Navigation("SoldTickets");
                });
#pragma warning restore 612, 618
        }
    }
}
