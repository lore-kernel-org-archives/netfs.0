Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B171A08C1
	for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919404; cv=none; b=PdMwbsA0Qz9nW7vdF/5Kyo8FV2C44ldBMLxJPBRHfKTHPLEZEmhuYB2/IETPGij3ZGEn60ZVTVUNQLZDgt+XztRdpk/4Y75/YsHfp9GriZ8rR45yqogUP0NqhYRwOjJY0oR7nNmGTo+4Mb6Ggc7sF1J6ElLj9iljONx6nya98B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919404; c=relaxed/simple;
	bh=US4amykFr5ddVKxjiqf9qV7P1EFpR8NMhdlERjZso+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVfXX/HlFWlQajRTXB+ZTfvyLnb7D83sJJ99bsOHayUK+Q8GCrLEuv1r6qEMI3a9qQdPzHNAOwCzsrwi8tIlfmpAZ0lF+dhjvbG9+XK1YYbPL3LnpJMVmt53s4LWmJNGxZ+LzWHdWv3ObWMTlwXru5sTz4P6YD453VZn4HzDlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DlrL/rje; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DlrL/rje"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa578d10d50so368972966b.1
        for <netfs@lists.linux.dev>; Fri, 29 Nov 2024 14:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732919400; x=1733524200; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=DlrL/rjejCWKeMmDbxjX6Ka2niq2qe/w8ZAubVFoPyiZQnvSooIZYhNrelEPVSe7af
         LMOKCkfkCeF9GEGJauXPgqgMAicaVBvGsP0D5CrGuaWpGbcFOsREWfN75hCD0AQfdsjz
         UMwI+JbLXzVOypWNRv66cR0zDtMkrPnQqMgTNqKJzYDVEmisPT125HpHUWw3nnk0H/s4
         ov6l6xtTCFwCgsb1KcyBxLVmk1jkp7kofYmN9CLrLV+uXITXZ4M7+/E1pSP3Hx+O88NL
         ZhLVfcumTW3t9D2W9X1nd9mOxvF688vZEk2l+kjM+W5JTXHQ8KKHkj6VpP41pypHbXZH
         q67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919400; x=1733524200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=YfZYbDSIU9Bqgc4qYV+fGjuoH3yghdXmhO7EvLW1M8YLuKxV0GzMIimUpkbY3tsXHG
         YEIXnnLMKms+SJfwkqkbItyye07/GdkzR2ZeLriUV4aEOht0Sv3CQN5lbQWRyO6Wz3MM
         l2MAU4QxW8mSIhU4etiDeZ39QPzqsxCCCdDrICYvw0dym655W8Kr5mlFY6eNYasofrqt
         N+QUcrETNE+SsZuCTJz99sGl4OHJUbWGWYLFIVoMbulWjXz69KsXWRG9V+tVaCZRmPHa
         IHw3uWVuDFNpoYjCZFt3NKsUc8dwZvd/ZIp1xwatYeqBJth7jDctb9umZ1lKQZoJFtL5
         sLzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWKb1Jnjje4bqd/TVPhRbY3gRB4GXPm2+QRcFLQ+Y4CIYtiHIXvkr1S/Xez84RPRjaItBnEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwqbZS3JHCMtD1YyVZvEc/0KgOEFm7fmeACM0lbb85HQIHHTk1
	HXnnGkUAs4VppR//T5F8IehY0g/AQe6RpXN+VRR1MOYaOwmXONPKIVLNd2eb426Rc0HsG1+lBkf
	Me/dqDT21VE14njtyiycj/ct8bJjgtILdBWoBXA==
X-Gm-Gg: ASbGncvQxoIBc1oPdr7ms+jUM+NZZjyVvfsZTw7ym3GEMLloYnnIlookyzg/QtQQP4q
	dKWZi4wLTAb6RFW8AGhFNKmFFE5Yrdi8gFW9m9JL4rc3VufJYYTxDpQc5BORJ
X-Google-Smtp-Source: AGHT+IGD6U3oaxtSMZQVfdy9TFXf1JM6pq//zBUlUW4tdizRmZ1hS6c7zHoDGfiwaAYKXgF9d5AcGO7Xuq+LWbOYwC4=
X-Received: by 2002:a17:906:4c2:b0:aa2:c98:a078 with SMTP id
 a640c23a62f3a-aa581076b06mr1442894966b.57.1732919400359; Fri, 29 Nov 2024
 14:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 23:29:49 +0100
Message-ID: <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

I have encountered multiple hangs with that branch; for example:

 [<0>] folio_wait_private_2_killable+0xfb/0x180
 [<0>] netfs_write_begin+0xe0/0x450
 [<0>] ceph_write_begin+0x27/0x50
 [<0>] generic_perform_write+0xcd/0x280
 [<0>] ceph_write_iter+0x4d9/0x640
 [<0>] iter_file_splice_write+0x308/0x550
 [<0>] splice_file_range_actor+0x29/0x40
 [<0>] splice_direct_to_actor+0xee/0x270
 [<0>] splice_file_range+0x80/0xc0
 [<0>] ceph_copy_file_range+0xb5/0x5b0
 [<0>] vfs_copy_file_range+0x320/0x5b0
 [<0>] __x64_sys_copy_file_range+0xef/0x200
 [<0>] do_syscall_64+0x64/0x100
 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

I can't be 100% sure if this was caused by your branch or if this is
just another 6.12 regression, but I haven't seen this with 6.11.
