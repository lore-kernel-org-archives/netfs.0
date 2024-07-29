Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACE1422C4
	for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252981; cv=none; b=El9bd7IaFDYAD53VTdBc3tFb+ZL+t6Oq2hjNxhRMxY2O39P4joGbsM4Pj8xqgDv7n4ByqMARjD4i+JDJBKORfe5a2aSxtjLpzAhsKT4IXDuh/r+onqeM03oTj2lcyNCy5iFSbjCE2kWiywGJI7HiFsMQs8anZFy77unsWA7kynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252981; c=relaxed/simple;
	bh=9d/TuvIi2gaVki/61lDkSdIbeGequPDx+pBjCZNjcnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpjOTqIQc8VPmvQGSTAnzFAUI+rYLjZGQ6fXOMDq+SljJy63YAhhPT4jENmGtDgVtNiq6JDR4NxLDgDSQzubzMObpBHz1zujN+dxv8vQo0/g8drNKxx6/KK2cgEx8jcKsgU+F8dvQmKMBFY3TcBCQJ6AObYQmU4ykOPdgZZqHYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hjLEQy2y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hjLEQy2y"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so447152266b.3
        for <netfs@lists.linux.dev>; Mon, 29 Jul 2024 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722252978; x=1722857778; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KF3mlZEDxsHIPxRij6eufhwBQK9CK0HzJYTYEnEj7k=;
        b=hjLEQy2y+sb/DMLU+Oum21kjygFoxfDWmQQFuSJsq+kiYpCRYDenj39j+zYPgo1H3P
         j0NzDYbiVa7pG4d1JXUISBYu6WPf0xhQqvm88W/k6Sum0eD6l5liw+QC3WOzi4h1VF3P
         k2RYAOW6H6o7rAg+DQezQvt0pyCdFyDerBA5L3VGAUob31KeGcmrbHl4/kqOt4jZ2nFC
         l9Nh7R4QixwRbcU8/f7+YLll4VXmhMPTBloldxfah06pgXNzicZn/Stk++S/imdGtihT
         BQJAfyQXQaeh70Ayzl0req9Kv8/S+Sl0f1icaVjYMUKApppqiS7cpFbJbv0+SNAhS/1j
         I4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252978; x=1722857778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KF3mlZEDxsHIPxRij6eufhwBQK9CK0HzJYTYEnEj7k=;
        b=ooqQE9zJhIQEiRVZaJOY2sN4xdjH1+JyFO8Xdg6yCxzI6CWjP8iVOmkA5PdKN/l4gn
         hup+5P26b2K6pxqCW6CAZrikIfCW0WGA0+hB09JGNfR5zvfxnR7F7o7ABPO5NXO1CgS1
         cPO6042Tq1rwibJMDhvlPX16Tjc8Pu22Eb7y/X/ksWLp4dix/Syw/LQmAQ0rxHCdoNoO
         KlAgrFIpjMIgPbImVrveL4v7cOmF/eJ0v+6zjeMA7YwpFI9Q/ArU5zGNMFewugIq+Vwj
         B0mYxYGlcl5rh4zBgv/5l4uk2uOZLRuFOfDfJlrJ6WQNNHHZPGFo7J6qYpIIXT1dquw5
         us4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0a9TqQ0zAXaZmh7jfy25Q2FxUJ7uSG0AzA+8BLDA60wjVsjIax81PteUwEjiG5a244K8vWVC0bovkz6T9QiNdkqwO/s8=
X-Gm-Message-State: AOJu0YwSQIp7dyBifr1ZC/Q3NCFCS7zC3ljayjPDb/CztjJ615aXF521
	cR0MKSvJ0+ifQLMEt0SS6wrXo6L56dYILYKhqMbvCMlBfjiznl/xjmeZ6sq+rUqlB1ZLydJQeqK
	Rwm2qGF4ptc5bjW47XZpTsXo2Mix6dut/WryjXg==
X-Google-Smtp-Source: AGHT+IGKpUG8GjQyZSSGXOjOMOggSW6ZJ6EszzZi7IF1MSWLkKJ/Q8dWEZAXvw9LMoCLxfRh6TQumDR0DdnGLtVJdlI=
X-Received: by 2002:a17:907:160a:b0:a7a:8cb9:7490 with SMTP id
 a640c23a62f3a-a7d4013523dmr456527566b.47.1722252977589; Mon, 29 Jul 2024
 04:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
 <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com> <CAKPOu+9xQXpYndbeCdx-sDZb1ZF3q5R-KC-ZYv_Z1nRezTn2fQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9xQXpYndbeCdx-sDZb1ZF3q5R-KC-ZYv_Z1nRezTn2fQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 13:36:05 +0200
Message-ID: <CAKPOu+8q_1rCnQndOj3KAitNY2scPQFuSS-AxeGru02nP9ZO0w@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:17=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>  BUG: kernel NULL pointer dereference, address: 0000000000000356

This is obviously NETFS_FOLIO_COPY_TO_CACHE; this looks like it was
caused by 2ff1e97587f4 ("netfs: Replace PG_fscache by setting
folio->private and marking dirty"). That commit uses
folio_attach_private(), but fs/ceph already used
folio_attach_private() for something else.
