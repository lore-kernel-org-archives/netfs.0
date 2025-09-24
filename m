Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123E19CCF5
	for <netfs@lists.linux.dev>; Wed, 24 Sep 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739965; cv=none; b=LTbdDHQ/VLU55h9eM+AO0od6SHAuamUX9MskRM46rvjvj1NkXzpBZD8RCy41j2IYC9sm36nilsvNbIJF0Dw5vM35DDjJQtCTh0r3d79Dbs80LcNZ88vl1e1OCkqqTnCqX3HCocPbFJ1/RU80bEHf0WP9v5k9hGCZ+FX1nEBzpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739965; c=relaxed/simple;
	bh=TrnfCbO733+lCXZrSFS09BJmX3fVRMEKZIVSt3/d0Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpz3qKCio+uOb316YbjsY37HbHLa9uhxXHWDQRHkBOVFvVPD+0SkWJD/FXdTIW8heq2m0N782CEIV/UkNtIhLe5ftxkUlrgzaNVkWs+uN1lMDYODU7cro7oahFUVWCGjBxEnp+k//7SUSh71vuxJU7uy32bYg5C5WaApXjaaA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MTFO0Lhl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MTFO0Lhl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2bddecc51aso27023066b.2
        for <netfs@lists.linux.dev>; Wed, 24 Sep 2025 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758739962; x=1759344762; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=MTFO0LhlvufX4MK7Jokm6Ei0cGw1THV8qu9AqBM9l3vkbE9LDO8yROIywrBHXmSJ+W
         RaNPuJTepDdLpPKZtdEky5wcD4RSbs34SaAS1zZuYa6EzXIlHuRnEuP5L17jjpIc4EFW
         At4ttBoQPIrgEi6q52EgYQi+PlfAPt5MDjSKlxZQItRA+xD0bfoV/sARxhPliRsQx2JO
         MSSq3p2WoBPcqhJ4kPC55Vu9tozeVD1npJLGhSHW2fN9ww746fG2HINDnplyGjTATipv
         5zdyKhUGCQMAdia4P0VXOPgkvCYKlOB8+qU26Sr0rEgVEXkDpYdfSw32MDnZXWFD2DKj
         CTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739962; x=1759344762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=ITzAhDsePWOm/5A82pRCDpV8jAe/MC975lCj/u7C64re/85gFBYcZzUE8Qifh4krdg
         nWq4A3zeyiTFIS7awifVnZVObUy1jJ7Z4JZuWvpLDl0QA0pQlmCRAnPwWimi4laGOWqb
         N4kn4ZxsYMfnuPuzOpYKs+JKMD/TLB89LXOmRZprDZGX83Iot4Axeiot1fHDk+G9g0mn
         TCf1bUWzV8RE/XrdlKzwBhVhMvM36Zz4Vbz8beD71lpjARDz+loqRxVODDGkujLr0dwl
         S0mcGUMN3CkCi9zJ7uPGx8DHTiqXwAW21gxdEt05sSpdkau4w0XEc1Ku5IJAGbCvtnXI
         /ZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK9Yk7RYEHBObncrTk//OdG9pW9BoP7C/lDlWFjn7zU1UZWVtFRJQHZRHOKg+j/Pwgj322cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqsT6cb7ApwQCxlJ8vSUgJUN2Tm21c1UDlrgEoNjMxjda0ri3j
	KQFTX2YKh6nuopEn0mlPYcNjCqMKLlJg7Zj815lYsh2pV3/i3WjGjX7u8uXnAhEd+NDpuyQ7yq0
	tT57xPum8mlms3ElDJVy4Pz6tV28EmB5NQVYkqPrtew==
X-Gm-Gg: ASbGnctBbpffdIuSjktQ+uT9d1Bn0+I2Mti38Z5YITFC6n0FFakG5aOVni4o8SV2cL8
	v6kaj+NvII1sW10NDWLkDLgCXrjx+hA1NbPhLN1nmVJXehvVsuc3B5AyjbxmqpYzw+82C7+HI3d
	LE6kgDbHxVZvOol/f1LxlU77Vl9RUyVK9whSTUqEbJN59QiBnPiC6LaHX8n/TkPLLuiOY2gAaVp
	GfUiYHzjqoa4a1gtg50qU+hePVBptf0bn4=
X-Google-Smtp-Source: AGHT+IEfLas0BqTe4LbLvHMPVeWuRAoGKff3BYuwff4/8Ek1I05jBqtCoUMSm2S1LlFiIk3FPlHI234+b1Girt9Hnx0=
X-Received: by 2002:a17:907:7e88:b0:b0c:6cae:51f5 with SMTP id
 a640c23a62f3a-b34bb8f1a7amr87587566b.43.1758739961642; Wed, 24 Sep 2025
 11:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
 <745741.1758727499@warthog.procyon.org.uk> <755695.1758728366@warthog.procyon.org.uk>
In-Reply-To: <755695.1758728366@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 24 Sep 2025 20:52:30 +0200
X-Gm-Features: AS18NWBX90PDeUbc5D76CTwvxhtp7GglnV1Nwwby_YGspEvXUsJA3vS2rse6AAs
Message-ID: <CAKPOu+9Ym+dRHQiMvjvdisnb5jwca4_2ECbzOMLYso=xNvxeQQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs: fix reference leak
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:39=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > > ... and frees the allocation (without the "call_rcu" indirection).
> >
> > Unfortunately, this isn't good.  The request has already been added to =
the
> > proc list and is removed in netfs_deinit_request() by netfs_proc_del_rr=
eq() -
> > but that means that someone reading /proc/fs/netfs/requests can be look=
ing at
> > it as you free it.

Oh, right. I saw the linked list operations were protected by a
spinlock, but I missed that this lock is not taken for traversal while
reading proc. I'll send v2 with your suggested fix.

> >
> > You still need the call_rcu() - or you have to call synchronize_rcu().
> >
> > I can change netfs_put_failed_request() to do the call_rcu() rather tha=
n
> > mempool_free()/netfs_stat_d().
>
> How about:
>
> /*
>  * Free a request (synchronously) that was just allocated but has failed =
before
>  * it could be submitted.
>  */
> void netfs_put_failed_request(struct netfs_io_request *rreq)
> {
>         int r;
>
>         /* New requests have two references (see netfs_alloc_request(), a=
nd
>          * this function is only allowed on new request objects
>          */
>         if (!__refcount_sub_and_test(2, &rreq->ref, &r))
>                 WARN_ON_ONCE(1);

You changed the refcount_read() check to an atomic decrement, but at
this point, nobody cares for the reference counter anymore (and my
check was just for bug-catching purposes).
Why bother doing the decrement?
