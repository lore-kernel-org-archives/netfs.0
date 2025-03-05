Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2911591E3
	for <netfs@lists.linux.dev>; Wed,  5 Mar 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202650; cv=none; b=YrptERFiCpDo6a4GXdM7Z7cXjDiTw62IGY6uWxCromAlKeLrocDAzq8tnnDTbIjkzR8KLmcIs6A/uOvjPjKzS1nMj5I9W5SC/vRkkG1480JnH8B1FBAD0lHdh5ftFMJF5S13TjzdDFXmiijbUpYSQGVPBQTXQPj/HgtF3qBytOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202650; c=relaxed/simple;
	bh=PGeSuNkaCiXYiJReUmFpejDpVXCPlwD9a+jRtHlbTlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZwKBzojpwFFX+qV0lg9yOdmXC/VgZRcBxfQmYQ/iKuXEYtBpFf803ccfZrA80S4TP9QdJsp9IEIyiRHBPn8gdHiyn/y5v3i5DFCmn+Uu+xFRpIzyPjjQK+6OPEmk186Bl17eOQF2ttaNhop9hIwdurZM+Y6IeFZHwF18eul4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M12QSRrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M12QSRrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741202647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knZE1VX+LlwYD9k4fEVN4dVQ0t7bukShujkee3U3hi4=;
	b=M12QSRrWX56HkcebwcdClGzRDtFuIPmLHRA/OId1aVAF5sxAMod14l2A1w+rSm0ahW7j7h
	VSATN6chl9qNEibmTBkL2cbmGTKjbYJqy2zx+sCijGI6Njmn5VKgNSH2w3H/wO+bd+0cyG
	nrlMZJi+KSc56Y9qAX5zox5PIZWrGIg=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-llhT68UGNje_cSwAFAbOPw-1; Wed, 05 Mar 2025 14:24:06 -0500
X-MC-Unique: llhT68UGNje_cSwAFAbOPw-1
X-Mimecast-MFC-AGG-ID: llhT68UGNje_cSwAFAbOPw_1741202646
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5237b102088so993574e0c.1
        for <netfs@lists.linux.dev>; Wed, 05 Mar 2025 11:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202646; x=1741807446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knZE1VX+LlwYD9k4fEVN4dVQ0t7bukShujkee3U3hi4=;
        b=uNIG2ZYFgn6dXWXo6w2qzyggwqfPutfQjxIPPKsug+F3SGVDm++Ka6De9QFEUbL7E2
         ZClBI5nAEnK2/6HgBUyEMVxClafg20hdwlNQqpxhxAaPtC9jjkGDfj2eCuA3dXziK6HN
         oQHulIE0q8vMwZZmb+anfq4U3E+RCyDWxbEvNBb4B7HKNrPaApilhrlMUAQBYzh6l7+a
         ga7yigWvuCWn4qqbVejV9zmBzrXgyGWraocIlwCFND8zxIwqeXNOs/H2dceel13hOxJ3
         lQs3CZye2qC9pKvmem4rfl+8w5ikpQ7b6d6QFJTt8zN8MZBn39kbaVU9mUj7gTviuOow
         neGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/OSfUcXuEmF8G1HHV++DknLhI60Dj5SnhhtYDpFnMI6NC3C+eW0dPnXMqWOhbe5J5/VdAUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziukjqATSyOgy//K3ieQngSEFmEvnJmjdHC2TVpDHJH+vVO2K2
	1zzGEPm4iSkpRt+IrjKceZ9lQegWWswE0o7DO4u5622fYgnpW/GcbsJMAAWy4OKsF4GpuFyVaRI
	aX8OPEean20sAGUl1sZP4C7iFeJKZ42aXOoVXjVjxU4kbxdgt96w+OF9qZGqXu1z+ZP1wUAdZss
	paW/vNSVUr4FTrWpprzatpmf1YrbQ=
X-Gm-Gg: ASbGncty++CmkySz6E+46S0ev+SNWoJCxcS29uZIwtyEC7zvWJTr7lY/q8ePWuVDPNl
	UCEs1hG8F5tSMdCNbDKVtXhl14SpJjxjTDBzgzUm7JrgHTqM3tYzCfZeVLm3v+5fC+HMzK2Rk
X-Received: by 2002:a05:6122:3a10:b0:523:8230:70db with SMTP id 71dfb90a1353d-523c62ef265mr2725085e0c.10.1741202646057;
        Wed, 05 Mar 2025 11:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3g32K+cbhNW7iVX+BsPrKqMNOPY4L66SSlI3W9yAkZWTctbmFOpxZr/0ZgMB7Kc1qnOuYLn53Bhz3Tc0DwAE=
X-Received: by 2002:a05:6122:3a10:b0:523:8230:70db with SMTP id
 71dfb90a1353d-523c62ef265mr2725075e0c.10.1741202645711; Wed, 05 Mar 2025
 11:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
In-Reply-To: <4170997.1741192445@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 5 Mar 2025 21:23:55 +0200
X-Gm-Features: AQ5f1JrxIznBL-H4czil5nVa1bIf7k0sarUmH9VATGhIapwAUaeW1UBogidw-y4
Message-ID: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Gregory Farnum <gfarnum@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o7B81UTZms0h1NwI8w5AFYZ8e4mH8t6hwYpKV3W1l_k_1741202646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's a good point, though there is no code on the client that can
generate this error, I'm not convinced that this error can't be
received from the OSD or the MDS. I would rather some MDS experts
chime in, before taking any drastic measures.

+ Greg, Venky, Patrik

On Wed, Mar 5, 2025 at 6:34=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Alex, Slava,
>
> I'm looking at making a ceph_netfs_write_iter() to handle writing to ceph
> files through netfs.  One thing I'm wondering about is the way
> ceph_write_iter() handles EOLDSNAPC.  In this case, it goes back to
> retry_snap and renegotiates the caps (amongst other things).  Firstly, do=
es it
> actually need to do this?  And, secondly, I can't seem to find anything t=
hat
> actually generates EOLDSNAPC (or anything relevant that generates ERESTAR=
T).
>
> Is it possible that we could get rid of the code that handles EOLDSNAPC?
>
> David
>

